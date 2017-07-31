Received: from eggs.gnu.org ([2001:4830:134:3::10]:60072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc55O-0003d4-Bw
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc55K-0006Ft-0d
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:25:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dc55J-0006CK-Px
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:25:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725143923.11241-1-den@openvz.org>
	<87iniclcmr.fsf@dusky.pond.sub.org>
	<de43dd07-8344-cdc6-b7d6-4abd87ca5081@redhat.com>
Date: Mon, 31 Jul 2017 09:25:41 +0200
In-Reply-To: <de43dd07-8344-cdc6-b7d6-4abd87ca5081@redhat.com> (Eric Blake's
	message of "Fri, 28 Jul 2017 13:14:24 -0500")
Message-ID: <87h8xtawzu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/28/2017 12:01 PM, Markus Armbruster wrote:
>> "Denis V. Lunev" <den@openvz.org> writes:
>>=20
>>> Calculate req_json only if trace_handle_qmp_command enabled.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> CC: Markus Armbruster <armbru@redhat.com>
>>> ---
>
>> Conflicts with Eric's commit 8a4613a, but I can resolve that in my tree.
>>=20
>> The commit message is too terse.  "Improve tracing" makes me think of
>> more informative traces, but that's not the case.  What exactly is
>> improved here?
>
> Reduce overhead when not tracing.  Without the patch, we are malloc'ing
> a QString and spending CPU cycles on converting a QObject to string,
> just for the sake of sticking the string in the trace message - if we
> aren't tracing, it's wasted effort.

What about:

    monitor: Reduce handle_qmp_command() tracing overhead

    We are malloc'ing a QString and spending CPU cycles on converting a
    QObject to string, just for the sake of sticking the string in the
    trace message.  Wasted when we aren't tracing.  Avoid that.

Denis?
