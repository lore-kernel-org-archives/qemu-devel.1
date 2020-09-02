Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412F1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E030920767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E030920767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRAs-0007FI-2k
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDRA3-0006it-44
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:42:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:49588
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDR9y-0005Wd-J4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:42:42 -0400
Received: from host86-179-247-31.range86-179.btcentralplus.com
 ([86.179.247.31] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDRAN-0007h4-Bm; Wed, 02 Sep 2020 12:43:08 +0100
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <156da43a-4744-ac6c-fc4b-54788a40b3e9@ilande.co.uk>
 <CABgObfYcaCsZNYof9nd7gzCOY_6qN5MV+xD6dw7W4D4ircsdaQ@mail.gmail.com>
 <7516c253-0448-b5cd-18a0-45caaebc1d05@ilande.co.uk>
 <0db09727-a909-71db-3628-4edb3ce87f2b@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <76488c26-a3a7-be05-01ec-b29985ab29e7@ilande.co.uk>
Date: Wed, 2 Sep 2020 12:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0db09727-a909-71db-3628-4edb3ce87f2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.179.247.31
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/13] Make QEMU installation relocatable
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.324,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 07:42, Paolo Bonzini wrote:
> On 02/09/20 08:09, Mark Cave-Ayland wrote:
>> diff --git a/configure b/configure
>> index f6638abadf..cb56d31a5d 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1015,6 +1015,9 @@ if test "$mingw32" = "yes" ; then
>>    prefix="/qemu"
>>    confsuffix=""
>>    libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -lwininet -liphlpapi -lnetapi32
>> $libs_qga"
>> +  ld_pwd=$(pwd -W)
>> +else
>> +  ld_pwd=$(pwd)
>>  fi
> 
> That wouldn't work for cross-compilation, but I got the idea. :)
> 
>>  werror=""
>> @@ -4290,7 +4293,7 @@ EOF
>>                symlink "$source_path/dtc/Makefile" "dtc/Makefile"
>>            fi
>>            fdt_cflags="-I${source_path}/dtc/libfdt"
>> -          fdt_ldflags="-L$PWD/dtc/libfdt"
>> +          fdt_ldflags="-L${ld_pwd}/dtc/libfdt"
>>            fdt_libs="$fdt_libs"
>>        elif test "$fdt" = "yes" ; then
>>            # Not a git build & no libfdt found, prompt for system install
>> @@ -5275,7 +5278,7 @@ case "$capstone" in
>>      else
>>        LIBCAPSTONE=libcapstone.a
>>      fi
>> -    capstone_libs="-L$PWD/capstone -lcapstone"
>> +    capstone_libs="-L${ld_pwd}/capstone -lcapstone"
>>      capstone_cflags="-I${source_path}/capstone/include"
>>      ;;
>>
>> @@ -6276,7 +6279,7 @@ case "$slirp" in
>>      fi
>>      mkdir -p slirp
>>      slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
>> -    slirp_libs="-L$PWD/slirp -lslirp"
>> +    slirp_libs="-L${ld_pwd}/slirp -lslirp"
>>      if test "$mingw32" = "yes" ; then
>>        slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
>>      fi
> 
> Since there is no recursive make anymore, these can be just
> -Ldtc/libfdt, -Lcapstone and -Lslirp.  Nice. :)

Yes indeed, a quick test with this diff on top of your patchset gives me a working
build and link (minus the manual patch still required to capstone):

diff --git a/configure b/configure
index f6638abadf..ac3ba88d8a 100755
--- a/configure
+++ b/configure
@@ -4290,7 +4290,7 @@ EOF
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
           fi
           fdt_cflags="-I${source_path}/dtc/libfdt"
-          fdt_ldflags="-L$PWD/dtc/libfdt"
+          fdt_ldflags="-Ldtc/libfdt"
           fdt_libs="$fdt_libs"
       elif test "$fdt" = "yes" ; then
           # Not a git build & no libfdt found, prompt for system install
@@ -5275,7 +5275,7 @@ case "$capstone" in
     else
       LIBCAPSTONE=libcapstone.a
     fi
-    capstone_libs="-L$PWD/capstone -lcapstone"
+    capstone_libs="-Lcapstone -lcapstone"
     capstone_cflags="-I${source_path}/capstone/include"
     ;;

@@ -6276,7 +6276,7 @@ case "$slirp" in
     fi
     mkdir -p slirp
     slirp_cflags="-I${source_path}/slirp/src -I$PWD/slirp/src"
-    slirp_libs="-L$PWD/slirp -lslirp"
+    slirp_libs="-Lslirp -lslirp"
     if test "$mingw32" = "yes" ; then
       slirp_libs="$slirp_libs -lws2_32 -liphlpapi"
     fi

>> I'll try again with the relocatable install later - do I still need to pass --prefix
>> into configure or should I leave that for now and just use DESTDIR?
> 
> You can just use DESTDIR.

This doesn't quite look right: I went with "make V=1 DESTDIR=/home/Mark/rel-qemu-git
install" and the resulting tree came out like this:

/home/Mark/rel-qemu-git:
total 20
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 msys64
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 qemu

/home/Mark/rel-qemu-git/msys64:
total 4
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 qemu

/home/Mark/rel-qemu-git/msys64/qemu:
total 29072
-rwxr-xr-x 1 Mark None   311296 Sep  2 11:26 qemu-edid.exe
-rwxr-xr-x 1 Mark None   496640 Sep  2 11:26 qemu-ga.exe
-rwxr-xr-x 1 Mark None  1650688 Sep  2 11:26 qemu-img.exe
-rwxr-xr-x 1 Mark None  1597440 Sep  2 11:26 qemu-io.exe
-rwxr-xr-x 1 Mark None  2001920 Sep  2 11:26 qemu-storage-daemon.exe
-rwxr-xr-x 1 Mark None 11850752 Sep  2 11:26 qemu-system-ppc.exe
-rwxr-xr-x 1 Mark None 11850752 Sep  2 11:26 qemu-system-ppcw.exe
drwxr-xr-x 1 Mark None        0 Sep  2 11:26 share

/home/Mark/rel-qemu-git/msys64/qemu/share:
total 4
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 locale

/home/Mark/rel-qemu-git/msys64/qemu/share/locale:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 bg
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 de_DE
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 fr_FR
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 hu
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 it
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 sv
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 tr
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 zh_CN

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/bg:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/bg/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1633 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/de_DE:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/de_DE/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1342 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/fr_FR:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/fr_FR/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1363 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/hu:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/hu/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1019 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/it:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/it/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1324 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/sv:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/sv/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1381 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/tr:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/tr/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1047 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/zh_CN:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 LC_MESSAGES

/home/Mark/rel-qemu-git/msys64/qemu/share/locale/zh_CN/LC_MESSAGES:
total 4
-rw-r--r-- 1 Mark None 1393 Sep  2 11:26 qemu.mo

/home/Mark/rel-qemu-git/qemu:
total 12068
drwxr-xr-x 1 Mark None       0 Sep  2 11:26 applications
-rw-r--r-- 1 Mark None    3211 Sep  2 11:26 bamboo.dtb
-rw-r--r-- 1 Mark None  131072 Sep  2 11:26 bios.bin
-rw-r--r-- 1 Mark None  262144 Sep  2 11:26 bios-256k.bin
-rw-r--r-- 1 Mark None   65536 Sep  2 11:26 bios-microvm.bin
-rw-r--r-- 1 Mark None    9779 Sep  2 11:26 canyonlands.dtb
-rw-r--r-- 1 Mark None   42903 Sep  2 11:26 edk2-licenses.txt
-rw-r--r-- 1 Mark None  240128 Sep  2 11:26 efi-e1000.rom
-rw-r--r-- 1 Mark None  240128 Sep  2 11:26 efi-e1000e.rom
-rw-r--r-- 1 Mark None  240128 Sep  2 11:26 efi-eepro100.rom
-rw-r--r-- 1 Mark None  238592 Sep  2 11:26 efi-ne2k_pci.rom
-rw-r--r-- 1 Mark None  238592 Sep  2 11:26 efi-pcnet.rom
-rw-r--r-- 1 Mark None  242688 Sep  2 11:26 efi-rtl8139.rom
-rw-r--r-- 1 Mark None  242688 Sep  2 11:26 efi-virtio.rom
-rw-r--r-- 1 Mark None  236032 Sep  2 11:26 efi-vmxnet3.rom
drwxr-xr-x 1 Mark None       0 Sep  2 11:26 firmware
-rw-r--r-- 1 Mark None  783192 Sep  2 11:26 hppa-firmware.img
drwxr-xr-x 1 Mark None       0 Sep  2 11:26 icons
drwxr-xr-x 1 Mark None       0 Sep  2 11:26 keymaps
-rw-r--r-- 1 Mark None    9216 Sep  2 11:26 kvmvapic.bin
-rw-r--r-- 1 Mark None    1024 Sep  2 11:26 linuxboot.bin
-rw-r--r-- 1 Mark None    1536 Sep  2 11:26 linuxboot_dma.bin
-rw-r--r-- 1 Mark None    1024 Sep  2 11:26 multiboot.bin
-rw-r--r-- 1 Mark None  696912 Sep  2 11:26 openbios-ppc
-rw-r--r-- 1 Mark None  382048 Sep  2 11:26 openbios-sparc32
-rw-r--r-- 1 Mark None 1593408 Sep  2 11:26 openbios-sparc64
-rw-r--r-- 1 Mark None   62144 Sep  2 11:26 opensbi-riscv32-generic-fw_dynamic.bin
-rw-r--r-- 1 Mark None  558668 Sep  2 11:26 opensbi-riscv32-generic-fw_dynamic.elf
-rw-r--r-- 1 Mark None   70792 Sep  2 11:26 opensbi-riscv64-generic-fw_dynamic.bin
-rw-r--r-- 1 Mark None  620424 Sep  2 11:26 opensbi-riscv64-generic-fw_dynamic.elf
-rw-r--r-- 1 Mark None  156328 Sep  2 11:26 palcode-clipper
-rw-r--r-- 1 Mark None    9882 Sep  2 11:26 petalogix-ml605.dtb
-rw-r--r-- 1 Mark None    8161 Sep  2 11:26 petalogix-s3adsp1800.dtb
-rw-r--r-- 1 Mark None    1536 Sep  2 11:26 pvh.bin
-rw-r--r-- 1 Mark None   67072 Sep  2 11:26 pxe-e1000.rom
-rw-r--r-- 1 Mark None   61440 Sep  2 11:26 pxe-eepro100.rom
-rw-r--r-- 1 Mark None   61440 Sep  2 11:26 pxe-ne2k_pci.rom
-rw-r--r-- 1 Mark None   61440 Sep  2 11:26 pxe-pcnet.rom
-rw-r--r-- 1 Mark None   61440 Sep  2 11:26 pxe-rtl8139.rom
-rw-r--r-- 1 Mark None   60416 Sep  2 11:26 pxe-virtio.rom
-rw-r--r-- 1 Mark None     850 Sep  2 11:26 QEMU,cgthree.bin
-rw-r--r-- 1 Mark None    1402 Sep  2 11:26 QEMU,tcx.bin
-rw-r--r-- 1 Mark None   18752 Sep  2 11:26 qemu_vga.ndrv
-rw-r--r-- 1 Mark None  154542 Sep  2 11:26 qemu-nsis.bmp
-rw-r--r-- 1 Mark None   42608 Sep  2 11:26 s390-ccw.img
-rw-r--r-- 1 Mark None   67232 Sep  2 11:26 s390-netboot.img
-rw-r--r-- 1 Mark None    4096 Sep  2 11:26 sgabios.bin
-rw-r--r-- 1 Mark None 1667280 Sep  2 11:26 skiboot.lid
-rw-r--r-- 1 Mark None  968368 Sep  2 11:26 slof.bin
-rw-r--r-- 1 Mark None  348512 Sep  2 11:20 trace-events-all
-rw-r--r-- 1 Mark None  349148 Sep  2 11:26 u-boot.e500
-rw-r--r-- 1 Mark None  524288 Sep  2 11:26 u-boot-sam460-20100605.bin
-rw-r--r-- 1 Mark None   38912 Sep  2 11:26 vgabios.bin
-rw-r--r-- 1 Mark None   39424 Sep  2 11:26 vgabios-ati.bin
-rw-r--r-- 1 Mark None   28672 Sep  2 11:26 vgabios-bochs-display.bin
-rw-r--r-- 1 Mark None   38912 Sep  2 11:26 vgabios-cirrus.bin
-rw-r--r-- 1 Mark None   39424 Sep  2 11:26 vgabios-qxl.bin
-rw-r--r-- 1 Mark None   28672 Sep  2 11:26 vgabios-ramfb.bin
-rw-r--r-- 1 Mark None   39424 Sep  2 11:26 vgabios-stdvga.bin
-rw-r--r-- 1 Mark None   39424 Sep  2 11:26 vgabios-virtio.bin
-rw-r--r-- 1 Mark None   39424 Sep  2 11:26 vgabios-vmware.bin

/home/Mark/rel-qemu-git/qemu/applications:
total 1
-rw-r--r-- 1 Mark None 134 Sep  2 11:26 qemu.desktop

/home/Mark/rel-qemu-git/qemu/firmware:
total 21
-rw-r--r-- 1 Mark None 696 Sep  2 11:19 50-edk2-i386-secure.json
-rw-r--r-- 1 Mark None 721 Sep  2 11:19 50-edk2-x86_64-secure.json
-rw-r--r-- 1 Mark None 602 Sep  2 11:19 60-edk2-aarch64.json
-rw-r--r-- 1 Mark None 590 Sep  2 11:19 60-edk2-arm.json
-rw-r--r-- 1 Mark None 647 Sep  2 11:19 60-edk2-i386.json
-rw-r--r-- 1 Mark None 672 Sep  2 11:19 60-edk2-x86_64.json

/home/Mark/rel-qemu-git/qemu/icons:
total 4
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 hicolor

/home/Mark/rel-qemu-git/qemu/icons/hicolor:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 128x128
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 16x16
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 24x24
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 256x256
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 32x32
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 48x48
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 512x512
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 64x64
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 scalable

/home/Mark/rel-qemu-git/qemu/icons/hicolor/128x128:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/128x128/apps:
total 12
-rw-r--r-- 1 Mark None 8286 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/16x16:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/16x16/apps:
total 4
-rw-r--r-- 1 Mark None 765 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/24x24:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/24x24/apps:
total 4
-rw-r--r-- 1 Mark None 1201 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/256x256:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/256x256/apps:
total 20
-rw-r--r-- 1 Mark None 17572 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/32x32:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/32x32/apps:
total 12
-rw-r--r-- 1 Mark None 4234 Sep  2 11:26 qemu.bmp
-rw-r--r-- 1 Mark None 1696 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/48x48:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/48x48/apps:
total 4
-rw-r--r-- 1 Mark None 2694 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/512x512:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/512x512/apps:
total 40
-rw-r--r-- 1 Mark None 38007 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/64x64:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/64x64/apps:
total 4
-rw-r--r-- 1 Mark None 3807 Sep  2 11:26 qemu.png

/home/Mark/rel-qemu-git/qemu/icons/hicolor/scalable:
total 0
drwxr-xr-x 1 Mark None 0 Sep  2 11:26 apps

/home/Mark/rel-qemu-git/qemu/icons/hicolor/scalable/apps:
total 32
-rw-r--r-- 1 Mark None 30955 Sep  2 11:26 qemu.svg

/home/Mark/rel-qemu-git/qemu/keymaps:
total 12
-rw-r--r-- 1 Mark None 4632 Aug 23 21:31 sl
-rw-r--r-- 1 Mark None 3346 Aug 23 21:31 sv


The main issues I can see are that the .exe files end up under /msys64/qemu and the
ROMs end up directly under /qemu rather than in $DESTDIR/share.

Do we know why there is also a qemu-system-ppcw.exe that appears?


ATB,

Mark.

