Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E8C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF0521743
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 22:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF0521743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVWd-0000wY-II
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 18:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnVWQ-0000SN-KE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnVWO-0000gP-Qc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:02:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnVWO-0000fX-KE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 18:02:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so7547442wrr.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g0Kd3a7wykMfHoOOL1q0nlwY75j1kQ35DgtX4mixSvk=;
 b=OzgCQjA7u+K95SpLnN63BNkOoYVKg3QTuS1WS5hCrtVMgjxTGq0zJ2ZkC4eFPtSJgd
 XiPDdlmnwRk5SHMtaKhhloPBLzZKU8b9c9NVT5aGNYQnEGWGCRqaph0t0j7Rq/AOJold
 ZjRZJMctoNxYTYvPxXqbPOOWJdP8inT8U4Ja1rwYEiaJd13JIOgC9lQEa+OPxglVsZ23
 n5EqZaHSyGZNeAvVC+xCqnpPv8efXqv8zQ9eUeUnK7N7AYA4pQxvGdxCVNHwcNI6gOmg
 Tq8TlQ3FoPlSvzQ66D6CbiE940NNdgnXdBOEBk2hECRZ5JnmK4o9vB/NSNhblNIzqanD
 e2uQ==
X-Gm-Message-State: APjAAAVWLVWhDyfZroBGKEGNTlCFqm3JdVWH1HeSfddaoYyPmCIu8WQR
 i7KFvaokUf0WlIqj2OFybC3Uyg==
X-Google-Smtp-Source: APXvYqw59E4rht6tT7nojWmBjBh2Yug0h3PyA5XlU5aZYY02e0eaDMZXPgpN4wlZEUg3gInu1lsrbQ==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr37923788wri.7.1563314522969; 
 Tue, 16 Jul 2019 15:02:02 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id a67sm20589068wmh.40.2019.07.16.15.02.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 15:02:02 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <156331275293.10055.15974017562419557887@c4a48874b076>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8b48b6f7-3ed7-8293-1243-06dc68727ea3@redhat.com>
Date: Wed, 17 Jul 2019 00:02:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156331275293.10055.15974017562419557887@c4a48874b076>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PULL 0/2] pflash-next patches for v4.1.0-rc1
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
Cc: kwolf@redhat.com, patchew-devel@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/19 11:32 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190716160143.394-1-philmd@redhat.com/
>
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Subject: [Qemu-devel] [PULL 0/2] pflash-next patches for v4.1.0-rc1
> Message-id: 20190716160143.394-1-philmd@redhat.com
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20190716211343.10792-1-pbonzini@redhat.com -> patchew/20190716211343.10792-1-pbonzini@redhat.com
> Submodule 'capstone' (https://git.qemu.org/git/capstone.git) registered for path 'capstone'
> Submodule 'dtc' (https://git.qemu.org/git/dtc.git) registered for path 'dtc'
> Submodule 'roms/QemuMacDrivers' (https://git.qemu.org/git/QemuMacDrivers.git) registered for path 'roms/QemuMacDrivers'
> Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
> Submodule 'roms/edk2' (https://git.qemu.org/git/edk2.git) registered for path 'roms/edk2'
> Submodule 'roms/ipxe' (https://git.qemu.org/git/ipxe.git) registered for path 'roms/ipxe'
> Submodule 'roms/openbios' (https://git.qemu.org/git/openbios.git) registered for path 'roms/openbios'
> Submodule 'roms/openhackware' (https://git.qemu.org/git/openhackware.git) registered for path 'roms/openhackware'
> Submodule 'roms/qemu-palcode' (https://git.qemu.org/git/qemu-palcode.git) registered for path 'roms/qemu-palcode'
> Submodule 'roms/seabios' (https://git.qemu.org/git/seabios.git/) registered for path 'roms/seabios'
> Submodule 'roms/seabios-hppa' (https://git.qemu.org/git/seabios-hppa.git) registered for path 'roms/seabios-hppa'
> Submodule 'roms/sgabios' (https://git.qemu.org/git/sgabios.git) registered for path 'roms/sgabios'
> Submodule 'roms/skiboot' (https://git.qemu.org/git/skiboot.git) registered for path 'roms/skiboot'
> Submodule 'roms/u-boot' (https://git.qemu.org/git/u-boot.git) registered for path 'roms/u-boot'
> Submodule 'roms/u-boot-sam460ex' (https://git.qemu.org/git/u-boot-sam460ex.git) registered for path 'roms/u-boot-sam460ex'
> Submodule 'slirp' (https://git.qemu.org/git/libslirp.git) registered for path 'slirp'
> Submodule 'tests/fp/berkeley-softfloat-3' (https://git.qemu.org/git/berkeley-softfloat-3.git) registered for path 'tests/fp/berkeley-softfloat-3'
> Submodule 'tests/fp/berkeley-testfloat-3' (https://git.qemu.org/git/berkeley-testfloat-3.git) registered for path 'tests/fp/berkeley-testfloat-3'
> Submodule 'ui/keycodemapdb' (https://git.qemu.org/git/keycodemapdb.git) registered for path 'ui/keycodemapdb'
> Cloning into 'capstone'...
> Submodule path 'capstone': checked out '22ead3e0bfdb87516656453336160e0a37b066bf'
> Cloning into 'dtc'...
> Submodule path 'dtc': checked out '88f18909db731a627456f26d779445f84e449536'
> Cloning into 'roms/QemuMacDrivers'...
> Submodule path 'roms/QemuMacDrivers': checked out '90c488d5f4a407342247b9ea869df1c2d9c8e266'
> Cloning into 'roms/SLOF'...
> Submodule path 'roms/SLOF': checked out 'ba1ab360eebe6338bb8d7d83a9220ccf7e213af3'
> Cloning into 'roms/edk2'...
> Submodule path 'roms/edk2': checked out '20d2e5a125e34fc8501026613a71549b2a1a3e54'
> Submodule 'SoftFloat' (https://github.com/ucb-bar/berkeley-softfloat-3.git) registered for path 'ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3'
> Submodule 'CryptoPkg/Library/OpensslLib/openssl' (https://github.com/openssl/openssl) registered for path 'CryptoPkg/Library/OpensslLib/openssl'
> Cloning into 'ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3'...
> Submodule path 'roms/edk2/ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3': checked out 'b64af41c3276f97f0e181920400ee056b9c88037'
> Cloning into 'CryptoPkg/Library/OpensslLib/openssl'...
> Submodule path 'roms/edk2/CryptoPkg/Library/OpensslLib/openssl': checked out '50eaac9f3337667259de725451f201e784599687'
> Submodule 'boringssl' (https://boringssl.googlesource.com/boringssl) registered for path 'boringssl'
> Submodule 'krb5' (https://github.com/krb5/krb5) registered for path 'krb5'
> Submodule 'pyca.cryptography' (https://github.com/pyca/cryptography.git) registered for path 'pyca-cryptography'
> Cloning into 'boringssl'...
> Submodule path 'roms/edk2/CryptoPkg/Library/OpensslLib/openssl/boringssl': checked out '2070f8ad9151dc8f3a73bffaa146b5e6937a583f'
> Cloning into 'krb5'...
> Submodule path 'roms/edk2/CryptoPkg/Library/OpensslLib/openssl/krb5': checked out 'b9ad6c49505c96a088326b62a52568e3484f2168'
> Cloning into 'pyca-cryptography'...
> Submodule path 'roms/edk2/CryptoPkg/Library/OpensslLib/openssl/pyca-cryptography': checked out '09403100de2f6f1cdd0d484dcb8e620f1c335c8f'
> Cloning into 'roms/ipxe'...
> Submodule path 'roms/ipxe': checked out 'de4565cbe76ea9f7913a01f331be3ee901bb6e17'
> Cloning into 'roms/openbios'...
> Submodule path 'roms/openbios': checked out 'c79e0ecb84f4f1ee3f73f521622e264edd1bf174'
> Cloning into 'roms/openhackware'...
> Submodule path 'roms/openhackware': checked out 'c559da7c8eec5e45ef1f67978827af6f0b9546f5'
> Cloning into 'roms/qemu-palcode'...
> Submodule path 'roms/qemu-palcode': checked out 'bf0e13698872450164fa7040da36a95d2d4b326f'
> Cloning into 'roms/seabios'...
> Submodule path 'roms/seabios': checked out 'a5cab58e9a3fb6e168aba919c5669bea406573b4'
> Cloning into 'roms/seabios-hppa'...
> Submodule path 'roms/seabios-hppa': checked out '0f4fe84658165e96ce35870fd19fc634e182e77b'
> Cloning into 'roms/sgabios'...
> Submodule path 'roms/sgabios': checked out 'cbaee52287e5f32373181cff50a00b6c4ac9015a'
> Cloning into 'roms/skiboot'...
> Submodule path 'roms/skiboot': checked out '261ca8e779e5138869a45f174caa49be6a274501'
> Cloning into 'roms/u-boot'...
> Submodule path 'roms/u-boot': checked out 'd3689267f92c5956e09cc7d1baa4700141662bff'
> Cloning into 'roms/u-boot-sam460ex'...
> Submodule path 'roms/u-boot-sam460ex': checked out '60b3916f33e617a815973c5a6df77055b2e3a588'
> Cloning into 'slirp'...
> Submodule path 'slirp': checked out 'f0da6726207b740f6101028b2992f918477a4b08'
> Cloning into 'tests/fp/berkeley-softfloat-3'...
> Submodule path 'tests/fp/berkeley-softfloat-3': checked out 'b64af41c3276f97f0e181920400ee056b9c88037'
> Cloning into 'tests/fp/berkeley-testfloat-3'...
> Submodule path 'tests/fp/berkeley-testfloat-3': checked out '5a59dcec19327396a011a17fd924aed4fec416b3'
> Cloning into 'ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d3220552280ef3d832ce'
> Switched to a new branch 'test'
> 
> === OUTPUT BEGIN ===
> checkpatch.pl: no revisions returned for revlist '1'

No idea what this means...

> === OUTPUT END ===
> 
> Test command exited with code: 255
> 
> 
> The full log is available at
> http://patchew.org/logs/20190716160143.394-1-philmd@redhat.com/testing.checkpatch/?type=message.

