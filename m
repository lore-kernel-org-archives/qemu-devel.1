Received: from eggs.gnu.org ([2001:4830:134:3::10]:55940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBPjD-0004sI-NP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBPjA-00025B-IU
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBPjA-000255-Dn
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 15:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FC3281A88B7
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 19:05:12 +0000 (UTC)
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-4-lersek@redhat.com>
	<5f76e0aa-389f-82b8-9bac-8405f51b8d2c@redhat.com>
	<20180425125446.GJ30024@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c2145dbd-5cbf-13df-76fe-68b86cde488e@redhat.com>
Date: Wed, 25 Apr 2018 21:05:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180425125446.GJ30024@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] qapi: add SysEmuTarget to "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 04/25/18 14:54, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 24, 2018 at 06:11:05PM -0500, Eric Blake wrote:
>> On 04/24/2018 04:45 PM, Laszlo Ersek wrote:
>>> We'll soon need an enumeration type that lists all the softmmu target=
s
>>> that QEMU (the project) supports. Introduce @SysEmuTarget to
>>> "common.json".
>>>
>>> Cc: "Daniel P. Berrange" <berrange@redhat.com>
>>> Cc: David Gibson <dgibson@redhat.com>
>>> Cc: Eric Blake <eblake@redhat.com>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>>> Cc: Markus Armbruster <armbru@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>> Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
>>> ---
>>>
>>
>>> +##
>>> +{ 'enum' : 'SysEmuTarget',
>>> +  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm3=
2',
>>> +             'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>> +             'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>> +             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4'=
,
>>> +             'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>> +             'x86_64', 'xtensa', 'xtensaeb' ] }
>>
>> x86_64 doesn't match our typical conventions of preferring '-' over '_=
';
>> also, wikipedia mentions both spellings but under the page name
>> 'x86-64'.  Is it worth switching that enum constant?
>>
>> https://en.wikipedia.org/wiki/X86-64
>=20
> I would not want that - SysEmuTarget is supposed to be correlated with
> the qemu-system-$TARGET  binary names and we use qemu-system-x86_64
> there.

Right; also TARGET_NAME is looked up as follows in patch #4, in
qmp_query_target():

+    info->arch =3D qapi_enum_parse(&SysEmuTarget_lookup, TARGET_NAME, -1=
,
+                                 &error_abort);

That would fail if we used "x86-64" here.

Thanks!
Laszlo
