Received: from eggs.gnu.org ([2001:4830:134:3::10]:46868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSfeW-0006qT-OL
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSfeU-0007tt-N8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:04:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSfeS-0007hu-W0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:04:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A926130BCD9D
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 10:03:59 +0000 (UTC)
References: <20181129180050.17797-1-pbonzini@redhat.com>
	<8fcdeb08-d87c-a236-de94-f5129aa3b99b@redhat.com>
	<20181130095830.GD8101@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2c9486a-e05b-b62e-d9d1-65a2b022c4d2@redhat.com>
Date: Fri, 30 Nov 2018 11:03:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181130095830.GD8101@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] glib-compat: work around g_test_message
 bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 30/11/18 10:58, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Nov 30, 2018 at 01:08:29AM +0100, Paolo Bonzini wrote:
>> On 29/11/18 19:00, Paolo Bonzini wrote:
>>> Subprocesses are created by glib without leaving the file descriptors
>>> open.  Therefore, g_test_message (and assertion failures, but those
>>> trigger when things are going bad anyway) will think that it is writi=
ng
>>> to the log file descriptor, but while actually stomping on the QMP
>>> file descriptor or similar.  This causes spurious failures, which are
>>> as nice to debug as the reader can imagine.  While I have opened a
>>> pull request on GLib, this will probably take a while to propagate
>>> to distros.
>>>
>>> I found this while working on qgraph, but the fix is generic.
>>
>> This is not a problem anymore if we switch from gtester to tap.  Do we
>> want it fixed anyway or not?
>=20
> IMHO the change to tap is not really something  we shoudl be doing
> at this point in the release cycle.

Of course---I wasn't suggesting that, the TAP switch is for 4.0.
However, this fix is not needed for 3.1 as far as I know, and we're
pretty late in 3.1's rc period too.

Paolo

> So I'd favour taking this fix
> for 3.1, even if it becomes redundant when we switch to tap in 4.0
