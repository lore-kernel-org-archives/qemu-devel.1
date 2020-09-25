Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ECCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2293320717
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 09:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNiR7EaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2293320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjcc-0006b1-Vj
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 05:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLjaX-0005a8-Um
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:00:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLjaT-0006VI-RB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 05:00:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so2752876wrn.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DybmowH9dT6NQGJrufqHqwshz2nqkFSKAqrfB83dVI4=;
 b=XNiR7EaFzRQhxZ7CHJt7Hwr2oHHqOiXhD2O1GbVstXdrrmncairbImFPK1jIRYzrSN
 jNPYCDPfDjkkMpx4ITC96DYAR7gWdLDwqRRlk6MPIIeroxh+deyld6as0m3KWqxgxo/I
 tC18cCZiaY8yvwzzL+DdEwU9NhxPolF9FmDxLKm65kL4f9HMcQKRwvs8cFa14Okbjvol
 qJX9tXf3mJD3Cf+1S8JzCnkfisknXuqWkhgFdLZv+7jXcwPl3Kt7ECxohaKTM3TdZSyf
 C06Tu4LzUzYG3G4Hl7GHaWwAsBpAOj0wTctlbMhBbkNUu+sxkC9V6sAtFLGcWdAdRxdM
 ooxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DybmowH9dT6NQGJrufqHqwshz2nqkFSKAqrfB83dVI4=;
 b=naXo6n+19qcfEYwUIQgLVdGF6LOmKNaXQoBmZ5Lti2D+rPx8wfrpsHFaZiBhZCUgAx
 NqBCIFinVWWGSVO31UkQfX/zegfPSkLE0zpqAbh0Q3IStwdl7/oKdY2fa66ZsuznNRY1
 Ap4sl7Ieow+jSjiwWuOIIdPz4XZ4XGH3UXHXUREjASOADTy3v4gR6eDANvsp4VgyBrFy
 2TyI6dnFHYHmjj6RLh2StxcWaFOSo2x2cNkuimOhIUQq38BFJHA9ixaPoIgnvnNNRxH2
 FLhnOViy5dOFF7pfz/6Mupiax+1hlXn9/dPlYr9bYY5XFDp32La2Z6bUJjs6Ll8GtuXg
 PfAg==
X-Gm-Message-State: AOAM533206WC68jetsVJbHRj0um2l5hZwV/p4Bodq4FZDeSQ4fS2TLIK
 zFaJaT+EXrOVA7Rb+IXy6L4=
X-Google-Smtp-Source: ABdhPJwcFzhwDxko+yWag2Knost7vTgqb4VoZiFVoEIcy+QI9KC5WFe1ZlAiXsOw/uNhCKjSZVo5Ng==
X-Received: by 2002:a5d:67d0:: with SMTP id n16mr3622605wrw.198.1601024413643; 
 Fri, 25 Sep 2020 02:00:13 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id f23sm2054645wmc.3.2020.09.25.02.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 02:00:12 -0700 (PDT)
Subject: Re: [PATCH] tests/vm: Add Haiku test based on their vagrant images
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alexander von Gluck IV <kallisti5@unixzen.com>, qemu-devel@nongnu.org
References: <20200906143439.1924930-1-kallisti5@unixzen.com>
 <00452072441b963bd56bcc9a8b758bfc@unixzen.com>
 <1d836472-8f5d-438f-2c4a-e09d3cbe1e87@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <7d49ad6e-8881-31f0-7c51-aadf6cda6671@amsat.org>
Date: Fri, 25 Sep 2020 11:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1d836472-8f5d-438f-2c4a-e09d3cbe1e87@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 10:49 AM, Philippe Mathieu-Daudé wrote:
> Hi Alexander,
> 
> On 9/6/20 4:41 PM, Alexander von Gluck IV wrote:
>> September 6, 2020 9:35 AM, "Alexander von Gluck IV" <kallisti5@unixzen.com> wrote:
>>> Signed-off-by: Alexander von Gluck IV <kallisti5@unixzen.com>
>>> ---
>>> tests/keys/vagrant | 27 +++++++++
>>> tests/keys/vagrant.pub | 1 +
>>> tests/vm/basevm.py | 5 +-
>>> tests/vm/haiku.x86_64 | 121 +++++++++++++++++++++++++++++++++++++++++
>>> 4 files changed, 152 insertions(+), 2 deletions(-)
>>> create mode 100644 tests/keys/vagrant
>>> create mode 100644 tests/keys/vagrant.pub
>>> create mode 100755 tests/vm/haiku.x86_64
>>>
>>> diff --git a/tests/keys/vagrant b/tests/keys/vagrant
>>> new file mode 100644
>>> index 0000000000..7d6a083909
>>> --- /dev/null
>>> +++ b/tests/keys/vagrant
>>> @@ -0,0 +1,27 @@
>>> +-----BEGIN RSA PRIVATE KEY-----
>>> +MIIEogIBAAKCAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzI
>>>
>>> diff --git a/tests/keys/vagrant.pub b/tests/keys/vagrant.pub
>>> new file mode 100644
>>> index 0000000000..18a9c00fd5
>>> --- /dev/null
>>> +++ b/tests/keys/vagrant.pub
>>> @@ -0,0 +1 @@
>>> +ssh-rsa
>>> AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oX
>>
>> A little background information for context. These are the Vagrant SSH keys which are packed with every vagrant OS image and allow OS access for automation.  The python vm tester knowing of these lets it leverage Vagrant OS images for testing without much work.
> 
> Please add this information as comment in the source files.
> 
>>
>>
>>
>>> --- a/tests/vm/basevm.py
>>> +++ b/tests/vm/basevm.py
>>> @@ -44,6 +44,7 @@ DEFAULT_CONFIG = {
>>> 'machine' : 'pc',
>>> 'guest_user' : "qemu",
>>> 'guest_pass' : "qemupass",
>>> + 'root_user' : "root",
>>> 'root_pass' : "qemupass",
>>> 'ssh_key_file' : SSH_KEY_FILE,
>>> 'ssh_pub_key_file': SSH_PUB_KEY_FILE,
>>> @@ -245,13 +246,13 @@ class BaseVM(object):
>>> return self._ssh_do(self._config["guest_user"], cmd, False)
>>>
>>> def ssh_root(self, *cmd):
>>> - return self._ssh_do("root", cmd, False)
>>> + return self._ssh_do(self._config["root_user"], cmd, False)
>>>
>>> def ssh_check(self, *cmd):
>>> self._ssh_do(self._config["guest_user"], cmd, True)
>>>
>>> def ssh_root_check(self, *cmd):
>>> - self._ssh_do("root", cmd, True)
>>> + self._ssh_do(self._config["root_user"], cmd, True)
>>>
>>> def build_image(self, img):
>>> raise NotImplementedError
>>
>>
>> Haiku's user is UID 0, so essentially our root user isn't named root.
>> This adds the (optional) ability to override the root username.
> 
> Ditto.
> 
>>
>>
>>> diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
>>> new file mode 100755
>>> index 0000000000..9777722f51
>>> --- /dev/null
>>> +++ b/tests/vm/haiku.x86_64
>>> @@ -0,0 +1,121 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Haiku VM image
>>> +#
>>> +# Copyright 2020 Haiku, Inc.
>>> +#
>>> +# Authors:
>>> +# Alexander von Gluck IV <kallisti5@unixzen.com>
>>> +#
>>> +# This code is licensed under the GPL version 2 or later. See
>>> +# the COPYING file in the top-level directory.
>>> +#
>>
>>
>> This build script works as expected, transferring the qemu archive over
>> via the virtio block device and building it.
>>
>> More information here (including output of tools):
>> https://bugs.launchpad.net/qemu/+bug/1715203
>>
>> This purpose of this is trying to prevent the need to remove
>> upstream qemu support for Haiku.
>>
>> We have some out-of-tree patches to fix the error seen in our ports, i'll
>> work on upstreaming these.
> 
> Please do, because so far this fail before compiling the 10th file:
> 
> slirp/src/tftp.c: In function 'tftp_read_data':
> slirp/src/tftp.c:113:50: error: 'O_BINARY' undeclared (first use in this
> function); did you mean 'L_INCR'?
>          spt->fd = open(spt->filename, O_RDONLY | O_BINARY);
>                                                   ^~~~~~~~
>                                                   L_INCR
> 
> To avoid using 4GB of temporary storage in my HOMEDIR I had
> to do this change:
> 
> -- >8 --
> --- a/tests/vm/haiku.x86_64
> +++ b/tests/vm/haiku.x86_64
> @@ -93,17 +93,15 @@ class HaikuVM(basevm.BaseVM):
> 
>      def build_image(self, img):
>          self.print_step("Downloading disk image")
> -        cvg = self._download_with_cache(self.link, sha256sum=self.csum)
> -        cgz = cvg + ".tar.gz"
> -        img_tmp = "./box.img"
> +        tarball = self._download_with_cache(self.link, sha256sum=self.csum)
> +
> +        self.print_step("Extracting disk image")
> +
> +        subprocess.check_call(["tar", "xzf", tarball, "./box.img", "-O"],
> +                              stdout=open(img, 'wb'))
> 
>          self.print_step("Preparing disk image")
> -
> -        subprocess.check_call(["cp", "-f", cvg, cgz])
> -        subprocess.check_call(["tar", "xvzf", cgz, img_tmp])
> -        subprocess.check_call(["chmod", "666", img_tmp])
> -
> -        self.boot(img_tmp)
> +        self.boot(img)
> 
>          # Wait for ssh to be available.
>          self.wait_ssh(wait_root=True, cmd="exit 0")
> @@ -112,9 +110,6 @@ class HaikuVM(basevm.BaseVM):
>          self.ssh_root("pkgman install -y %s" % " ".join(self.requirements))
>          self.graceful_shutdown()
> 
> -        if os.path.exists(cgz):
> -            os.remove(cgz)
> -        subprocess.check_call(["mv", img_tmp, img])
>          self.print_step("All done")
> 
>  if __name__ == "__main__":
> ---
> 
> Note that something is not working well in your script because
> the image is extracted/reinstalled each time. This has to be
> done once, then we reuse the image for the builds.

I figured out make was removing the image as a temporary file,
because you didn't added it in the IMAGES variable, so this is
the fix:

-- >8 --
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -4,7 +4,7 @@

 EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)

-IMAGES := freebsd netbsd openbsd centos fedora
+IMAGES := freebsd netbsd openbsd centos fedora haiku.x86_64
 ifneq ($(GENISOIMAGE),)
 IMAGES += ubuntu.i386 centos
 ifneq ($(EFI_AARCH64),)
---

> 
> Also, please address Thomas comment.

Which is:

-- >8 --
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -41,6 +41,7 @@ endif
 else
        @echo "  (install genisoimage to build centos/ubuntu images)"
 endif
+       @echo "  vm-build-haiku.x86_64           - Build QEMU in Haiku VM"
        @echo ""
        @echo "  vm-build-all                    - Build QEMU in all VMs"
        @echo "  vm-clean-all                    - Clean up VM images"
---
> 
> Thanks,
> 
> Phil.
> 

