Received: from eggs.gnu.org ([2001:4830:134:3::10]:42828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8TqL-0003k6-Me
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f8TqI-0005rI-Cz
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:52:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f8TqI-0005qH-7i
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 12:52:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61E5B8DC46
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 16:52:26 +0000 (UTC)
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
	<7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
	<87efjeaqd2.fsf@dusky.pond.sub.org> <20180417140540.GD15421@redhat.com>
	<21d78c43-a6d9-95d8-ff3e-f80a9ce6b0c0@redhat.com>
	<87po2x6gz1.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8c20b01d-d756-d251-268c-f8df14a9b8c4@redhat.com>
Date: Tue, 17 Apr 2018 18:52:20 +0200
MIME-Version: 1.0
In-Reply-To: <87po2x6gz1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 17.04.2018 16:32, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 17/04/2018 16:05, Daniel P. Berrang=C3=A9 wrote:
>>>> For what it's worth, my "[RFC PATCH 00/32] Command line QAPIfication=
"
>>>> replaces the original parsing art by getopt_long_only().
>>>>
>>>> Completing that work will take some time, but once it's done, we can
>>>> (and I think we should) prefer double-dash for consistency.
>>> Since our existing parser accepts single & double-dash already, is it
>>> worth explicitly deprecating single-dash usage right now. So that whe=
n
>>> your code comes along ready to merge, we're already able to say
>>> "i told you so" and drop single-dash support at that same time.
>>
>> Serious questions: is _anyone_ of you actually using double-dash suppo=
rt
>> in daily invocations of QEMU?
>=20
> I use both.  I readily concede that people familiar with QEMU probably
> use single dash a lot more than double dash.  I don't think we should
> get rid of single dash, unless we decide to bite the bullet and clean u=
p
> our command line without regard for backward compatibility, as Thomas
> proposed elsewhere in this thread, and others proposed before, multiple
> times.

/me sings the QEMU version 3.0 blues ...

;-)
