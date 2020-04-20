Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A0C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671B02078A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 11:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7ZcnQWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671B02078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQUby-00045v-Kh
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 07:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37708 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQUbH-0003gn-50
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:28:32 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQUbG-0002hU-Ja
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:28:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56256
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQUbG-0002h1-7g
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 07:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587382109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxEsomGpwdt5h1nj5UdlkOh+yCEg41+Ke/8PWUKKwVM=;
 b=W7ZcnQWP8RPYc6NfIfi8iqqtKOnBFdNGgYHm1HzZx2cltVHV+zJceoM809Bxc/GMj+DqHE
 qQyII88VaOVjYc5ImWLyEgTBjVQ2HZSReJXXLQk31Uzg7yU9ME6rgA8Fmpgb5gDqdOs8NX
 M3xysDFiNLwPsDt1phDJGu4u0D3bLxQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-GBYMtm_FMY6Xsonmx64Q2g-1; Mon, 20 Apr 2020 07:28:27 -0400
X-MC-Unique: GBYMtm_FMY6Xsonmx64Q2g-1
Received: by mail-ej1-f72.google.com with SMTP id cb22so6135859ejb.12
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 04:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tym3BsMzhJaYH/XwL60dGHFaf376eJ6FTLG6eKM+p9w=;
 b=cvcD5Z2V+SvARL8GbqaMF4yMkx5k0O5RhkiJpDrNyvLmtoVgEPSu/Zn5xggK59o903
 rSfY6eSJSvSvaqqfBGHErt0rJXqS7dPo9j2vu3gItk0sg6BijMUwTZlc0G/1CI0yUz8y
 jF1K1UDg6LWMbCbmww1lj4osLwr2FGuAKPyxwzsctsdkx/XOlvJZbRiiUsmBc/0tfXSZ
 +fWsmsJ4w/SJsv/BNKc50V4BmdCf0K+KwjDLTwdVCD+lpwkkDzbYgOyBB8yRX89xhQ7a
 IV44NSwgWIiFi0J/twohTLmJWonkBca/inyzJo0w6jcXir5sLRDFa1axzlXxBGTMTXiz
 80nA==
X-Gm-Message-State: AGi0PuaotNciZLhT3YQF9f42v62e6K7fndj1XzkqcqdtZpWo50JzRmTA
 n/rMIET/aA1bDwXmN+u65PioS9naX94jRqLHhCIs/SGbFYIQgR4WUZoksGqhgTUzMsRsxfHBM6O
 olaJNm1k7IXwOTUk=
X-Received: by 2002:a17:907:42d6:: with SMTP id
 ng6mr15343092ejb.265.1587382106444; 
 Mon, 20 Apr 2020 04:28:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypK/jf/UDBngqXRvtcBtH88plPvnZUhfi2eoOIHtxf26xmSnNS9KIZBhkeI/sbhK/Bpc0quqcg==
X-Received: by 2002:a17:907:42d6:: with SMTP id
 ng6mr15343067ejb.265.1587382106157; 
 Mon, 20 Apr 2020 04:28:26 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id g2sm53337edm.77.2020.04.20.04.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 04:28:25 -0700 (PDT)
Subject: Re: [PATCH 09/11] target/mips: Always enable CONFIG_SEMIHOSTING
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-10-philmd@redhat.com>
 <d07835cf-1021-7399-a28d-09a4a4c225ef@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9a138460-9b08-a8bd-ecc9-78f6b227e972@redhat.com>
Date: Mon, 20 Apr 2020 13:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d07835cf-1021-7399-a28d-09a4a4c225ef@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

TLDR "how can I select a arch-specific feature?"

On 3/18/20 11:31 AM, Paolo Bonzini wrote:
> On 16/03/20 13:00, Philippe Mathieu-Daud=C3=A9 wrote:
>> diff --git a/default-configs/mips-linux-user-common.mak b/default-config=
s/mips-linux-user-common.mak
>> new file mode 100644
>> index 0000000000..04947706e8
>> --- /dev/null
>> +++ b/default-configs/mips-linux-user-common.mak
>> @@ -0,0 +1,4 @@
>> +# Common mips*-linux-user CONFIG defines
>> +
>> +# CONFIG_SEMIHOSTING is always required on this architecture
>> +CONFIG_SEMIHOSTING=3Dy
>=20
> If it is always required, it should be select-ed.

I'm not sure how to do that...

Currently we have in hw/semihosting/Kconfig:

config SEMIHOSTING
     bool
     depends on TCG
     default n

The only per-target generic entry point is minikconf command line.

1/ The less ugly option might be to add an optional target-devices.mak:

-- >8 --
diff --git a/Makefile.target b/Makefile.target
--- a/Makefile.target
+++ b/Makefile.target
@@ -5,6 +5,7 @@ BUILD_DIR?=3D$(CURDIR)/..
  include ../config-host.mak
  include config-target.mak
  include $(SRC_PATH)/rules.mak
+-include $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/target-devices.mak

  ifdef CONFIG_SOFTMMU
  include config-devices.mak
diff --git a/target/arm/target-devices.mak b/target/arm/target-devices.mak
new file mode 100644
--- /dev/null
+++ b/target/arm/target-devices.mak
@@ -0,0 +1 @@
+CONFIG_SEMIHOSTING=3Dy
---

2/ I can have ./configure adding in config-devices.mak:

-- >8 --
@@ -7778,6 +7778,7 @@ echo "# Automatically generated by configure - do=20
not modify" > $config_target_m

  bflt=3D"no"
  mttcg=3D"no"
+target_require_semihosting=3D"no"
  interp_prefix1=3D$(echo "$interp_prefix" | sed "s/%M/$target_name/g")
  gdb_xml_files=3D""

@@ -7806,6 +7807,7 @@ case "$target_name" in
      TARGET_SYSTBL_ABI=3Dcommon,oabi
      bflt=3D"yes"
      mttcg=3D"yes"
+    target_require_semihosting=3D"yes"
      gdb_xml_files=3D"arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
    ;;
    aarch64|aarch64_be)
@@ -7813,6 +7815,7 @@ case "$target_name" in
      TARGET_BASE_ARCH=3Darm
      bflt=3D"yes"
      mttcg=3D"yes"
+    target_require_semihosting=3D"yes"
      gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml=20
arm-vfp.xml arm-vfp3.xml arm-neon.xml"
    ;;
    cris)
@@ -8031,7 +8034,10 @@ fi
  if test "$target_bsd_user" =3D "yes" ; then
    echo "CONFIG_BSD_USER=3Dy" >> $config_target_mak
  fi

+if test "$target_require_semihosting" =3D "yes" ; then
+  echo "$target/config-devices.mak: CONFIG_SEMIHOSTING=3Dy" >>=20
$config_host_mak
+fi
---

3/ Or force MINIKCONF_ARGS:

---
if test "$target_require_semihosting" =3D "yes" ; then
   echo "MINIKCONF_ARGS +=3D CONFIG_SEMIHOSTING=3Dy" >> $config_target_mak
fi
---

Also note for ARM all configs require it, but for MIPS we only want it=20
for user-mode.

With 1/ this can be done as:

-- >8 --
diff --git a/target/mips/target-devices.mak b/target/mips/target-devices.ma=
k
new file mode 100644
--- /dev/null
+++ b/target/mips/target-devices.mak
@@ -0,0 +1,3 @@
+ifndef CONFIG_SOFTMMU
+CONFIG_SEMIHOSTING=3Dy
+endif
---

>=20
> Same for patch 10.
>=20
> Paolo
>=20


