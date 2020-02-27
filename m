Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD5BC35677
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4EF2469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARGaC8Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4EF2469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7L0G-0003Tv-Hy
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7KzK-0002tK-Ll
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7KzI-00015p-BV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:22:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7KzI-00014y-7p
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582816927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3vptr+NA/0VSQmtdpXwYlgQSk6B3ZzihUyqzlMdy+w=;
 b=ARGaC8Edqkjtu9nZK9FMVli8k6FIgchsywoAWbNdOWmHu2x0zx49am8BFnR7QPPUN8efJU
 BKAGcIFP+TtEiALI89c7gyYfbbwKBsJGfOYNDunpWMyqVkKFjQBEx35Hd/7ge+CdOe9+wW
 k4y7zhZwxFma1EJqifkrWH4yALV01iw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-alb68LGSOxmTklmyZ-d2Sw-1; Thu, 27 Feb 2020 10:22:01 -0500
X-MC-Unique: alb68LGSOxmTklmyZ-d2Sw-1
Received: by mail-wm1-f72.google.com with SMTP id b8so1773202wmj.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ymuxKcTFtjpUB4Mya7Jrd5d8ISYsxsTlDxA9mZ7edew=;
 b=LGZdGKz/uBGBi2dM9Lxc+bYx8TL/18SZvH2QhriYEmU30yre6tQH5M/FfIGKcBg951
 a7/2c8fC+50e9goyvOlY15eI0W1NOZTsBprL03r2IuyVBsuBlU1fk8FeK84VAsiW+Bi6
 ysgQg5hUd8qVkYMtLYJjrWi8x/BQke8qkOeUkd5eUUANVllCLgQ2wfNjSx/057C6pQAD
 GgigUHLf7XxcEi+v1wovtIG3MsYNz6ygIVGufqA+YTzbZMpf5O2mKdyKVMYdQqsxBXLN
 7gPoFVXKmySyNWpKLPZVTbQyG3DkI0ktF8QqxG1YmDmavnNYJFzhd6TtWFCEZgGww/2g
 1NOA==
X-Gm-Message-State: APjAAAWH7YqGqOi/H0xPUGLPPrSEC8IO4Gamm27AuDCWr59uQgiKvblw
 7mRFhfnaksKS0oLYuUTZMODtiP/SFHYFugJngsss3N8InGiNjTD8bKFA06TYtLPeOK6rUIPiZRk
 kVq5QeHl0T0Tghi8=
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr52725wmh.104.1582816920208;
 Thu, 27 Feb 2020 07:22:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxk37B+90cR0WsImM7k+NjtSeAoHhn1F/Gol4IOth83dLlnxnqQeXtBwgdWgpWrXJS2ElYheg==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr52699wmh.104.1582816919893;
 Thu, 27 Feb 2020 07:21:59 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id y17sm8201083wrs.82.2020.02.27.07.21.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 07:21:58 -0800 (PST)
Subject: Re: [PATCH v2] qapi/machine: Place the 'Notes' tag after the 'Since'
 tag
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20200227134019.6218-1-philmd@redhat.com>
 <87tv3cozfw.fsf@dusky.pond.sub.org>
 <c27cdab5-23a9-78f4-994a-49aaf96eb487@redhat.com>
Message-ID: <49248832-6ce3-a545-0ee3-8bd3ce664725@redhat.com>
Date: Thu, 27 Feb 2020 16:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c27cdab5-23a9-78f4-994a-49aaf96eb487@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 3:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/27/20 3:52 PM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> This fixes when adding a 'Since' tag:
>>>
>>> =C2=A0=C2=A0 In file included from qapi/qapi-schema.json:105:
>>> =C2=A0=C2=A0 qapi/machine.json:25:1: '@arch:' can't follow 'Notes' sect=
ion
>>
>> I'm confused.=C2=A0 This error is detected in scripts/qapi/parser.py, an=
d it
>> is fatal.=C2=A0 Is the build broken for you?=C2=A0 It isn't for me.=C2=
=A0 Moreover,
>> where is @arch?=C2=A0 I can't see it anywhere close to the two spots the
>> patch patches.
>=20
> I get the error after trying to fix what Eric commented here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg682344.html

Using:
---
diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a..40a36d6276 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -20,13 +20,15 @@
  #        prefix to produce the corresponding QEMU executable name. This
  #        is true even for "qemu-system-x86_64".
  #
+# @rx: since 5.0
+#
  # Since: 3.0
  ##
  { 'enum' : 'SysEmuTarget',
    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
-             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
               'x86_64', 'xtensa', 'xtensaeb' ] }
---

or

---
diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a..4b59e87b6f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -21,12 +21,14 @@
  #        is true even for "qemu-system-x86_64".
  #
  # Since: 3.0
+#
+# @rx: since 5.0
  ##
  { 'enum' : 'SysEmuTarget',
    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
-             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
               'x86_64', 'xtensa', 'xtensaeb' ] }
---

I get:

   GEN     qapi-gen
   GEN     rx-softmmu/config-devices.mak
In file included from qapi/qapi-schema.json:105:
qapi/machine.json:23:1: '@rx:' can't follow 'Notes' section
make: *** [Makefile:645: qapi-gen-timestamp] Error 1

This works however:

---
  ##
  # @SysEmuTarget:
  #
  # The comprehensive enumeration of QEMU system emulation ("softmmu")
  # targets. Run "./configure --help" in the project root directory, and
  # look for the *-softmmu targets near the "--target-list" option. The
  # individual target constants are not documented here, for the time
  # being.
  #
+# @rx: since 5.0
+#
  # Notes: The resulting QMP strings can be appended to the "qemu-system-"
  #        prefix to produce the corresponding QEMU executable name. This
  #        is true even for "qemu-system-x86_64".
  #
  # Since: 3.0
  ##
  { 'enum' : 'SysEmuTarget',
    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
-             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
               'x86_64', 'xtensa', 'xtensaeb' ] }
---

>=20
>>
>>>
>>> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> v2: Fix another occurrence in CpuInstanceProperties (Liam Merwick)
>>> ---
>>> =C2=A0 qapi/machine.json | 8 ++++----
>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 6c11e3cf3a..3d8b5324f3 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -16,11 +16,11 @@
>>> =C2=A0 # individual target constants are not documented here, for the t=
ime
>>> =C2=A0 # being.
>>> =C2=A0 #
>>> +# Since: 3.0
>>> +#
>>> =C2=A0 # Notes: The resulting QMP strings can be appended to the=20
>>> "qemu-system-"
>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prefix to produce th=
e corresponding QEMU executable name.=20
>>> This
>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is true even for "qe=
mu-system-x86_64".
>>> -#
>>> -# Since: 3.0
>>> =C2=A0 ##
>>> =C2=A0 { 'enum' : 'SysEmuTarget',
>>> =C2=A0=C2=A0=C2=A0 'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa'=
, 'i386',=20
>>> 'lm32',
>>> @@ -820,13 +820,13 @@
>>> =C2=A0 # @die-id: die number within node/board the CPU belongs to (Sinc=
e 4.1)
>>> =C2=A0 # @core-id: core number within die the CPU belongs to# @thread-i=
d:=20
>>> thread number within core the CPU belongs to
>>> =C2=A0 #
>>> +# Since: 2.7
>>> +#
>>> =C2=A0 # Note: currently there are 5 properties that could be present
>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but management should be p=
repared to pass through other
>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties with device_add=
 command to allow for future
>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interface extension. This =
also requires the filed names to=20
>>> be kept in
>>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sync with the properties p=
assed to -device/device_add.
>>> -#
>>> -# Since: 2.7
>>> =C2=A0 ##
>>> =C2=A0 { 'struct': 'CpuInstanceProperties',
>>> =C2=A0=C2=A0=C2=A0 'data': { '*node-id': 'int',
>>


