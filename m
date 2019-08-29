Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF49C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C4A2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C4A2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Nvo-00062Q-Ne
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i3Nov-0005as-B6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i3Nor-0004hG-OE
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:02:49 -0400
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:50136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i3Nor-0004gt-FG
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:02:45 -0400
Received: from player159.ha.ovh.net (unknown [10.108.54.156])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4730076FC9
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 19:02:43 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 554C69280A0B;
 Thu, 29 Aug 2019 17:02:35 +0000 (UTC)
Date: Thu, 29 Aug 2019 19:02:34 +0200
From: Greg Kurz <groug@kaod.org>
To: no-reply@patchew.org
Message-ID: <20190829190234.41c8d988@bahia.lan>
In-Reply-To: <156651233307.28865.18175668587519528989@5dec9699b7de>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <156651233307.28865.18175668587519528989@5dec9699b7de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 374361721164175736
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeivddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.49.171
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
Cc: stefanha@gmail.com, berrange@redhat.com, qemu-devel@nongnu.org,
 antonios.motakis@huawei.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 15:18:54 -0700 (PDT)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/cover.1566503584.git.qemu_oss@crudebyte.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Subject: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
> Message-id: cover.1566503584.git.qemu_oss@crudebyte.com
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
>  * [new tag]         patchew/cover.1566503584.git.qemu_oss@crudebyte.com -> patchew/cover.1566503584.git.qemu_oss@crudebyte.com
> Submodule 'capstone' (https://git.qemu.org/git/capstone.git) registered for path 'capstone'
> Submodule 'dtc' (https://git.qemu.org/git/dtc.git) registered for path 'dtc'
> Submodule 'roms/QemuMacDrivers' (https://git.qemu.org/git/QemuMacDrivers.git) registered for path 'roms/QemuMacDrivers'
> Submodule 'roms/SLOF' (https://git.qemu.org/git/SLOF.git) registered for path 'roms/SLOF'
> Submodule 'roms/edk2' (https://git.qemu.org/git/edk2.git) registered for path 'roms/edk2'
> Submodule 'roms/ipxe' (https://git.qemu.org/git/ipxe.git) registered for path 'roms/ipxe'
> Submodule 'roms/openbios' (https://git.qemu.org/git/openbios.git) registered for path 'roms/openbios'
> Submodule 'roms/openhackware' (https://git.qemu.org/git/openhackware.git) registered for path 'roms/openhackware'
> Submodule 'roms/opensbi' (https://git.qemu.org/git/opensbi.git) registered for path 'roms/opensbi'
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
> Submodule path 'roms/SLOF': checked out '7bfe584e321946771692711ff83ad2b5850daca7'
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
> Cloning into 'roms/opensbi'...
> Submodule path 'roms/opensbi': checked out 'ce228ee0919deb9957192d723eecc8aaae2697c6'
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
> Submodule path 'slirp': checked out '126c04acbabd7ad32c2b018fe10dfac2a3bc1210'
> Cloning into 'tests/fp/berkeley-softfloat-3'...
> Submodule path 'tests/fp/berkeley-softfloat-3': checked out 'b64af41c3276f97f0e181920400ee056b9c88037'
> Cloning into 'tests/fp/berkeley-testfloat-3'...
> Submodule path 'tests/fp/berkeley-testfloat-3': checked out '5a59dcec19327396a011a17fd924aed4fec416b3'
> Cloning into 'ui/keycodemapdb'...
> Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d3220552280ef3d832ce'
> Switched to a new branch 'test'
> 28d6fb8 9p: Use variable length suffixes for inode remapping
> 23fc4f6 9p: stat_to_qid: implement slow path
> f227708 9p: Added virtfs option 'multidevs=remap|forbid|warn'
> bb69de6 9p: Treat multiple devices on one export as an error
> 
> === OUTPUT BEGIN ===
> 1/4 Checking commit bb69de63f788 (9p: Treat multiple devices on one export as an error)
> ERROR: Author email address is mangled by the mailing list
> #2: 
> Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> 

This is problematic since it ends up in the Author: field in git. Please find
a way to fix that.

Other warnings/errors should also be fixed but they look trivial.

> total: 1 errors, 0 warnings, 175 lines checked
> 
> Patch 1/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 2/4 Checking commit f227708a87da (9p: Added virtfs option 'multidevs=remap|forbid|warn')
> ERROR: Author email address is mangled by the mailing list
> #2: 
> Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> 
> WARNING: Block comments use a leading /* on a separate line
> #167: FILE: hw/9pfs/9p.c:600:
> +/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
> 
> ERROR: line over 90 characters
> #467: FILE: vl.c:3338:
> +                const char *writeout, *sock_fd, *socket, *path, *security_model, *multidevs;
> 
> total: 2 errors, 1 warnings, 394 lines checked
> 
> Patch 2/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 3/4 Checking commit 23fc4f6d5258 (9p: stat_to_qid: implement slow path)
> ERROR: Author email address is mangled by the mailing list
> #2: 
> Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> 
> WARNING: line over 80 characters
> #79: FILE: hw/9pfs/9p.c:622:
> +        qht_init(&pdu->s->qpf_table, qpf_lookup_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
> 
> total: 1 errors, 1 warnings, 142 lines checked
> 
> Patch 3/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 4/4 Checking commit 28d6fb899725 (9p: Use variable length suffixes for inode remapping)
> ERROR: Author email address is mangled by the mailing list
> #2: 
> Author: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
> 
> ERROR: space prohibited after that open parenthesis '('
> #92: FILE: hw/9pfs/9p.c:586:
> +    return ((uint64_t)mirror8bit( value        & 0xff) << 56) |
> 
> ERROR: space prohibited before that close parenthesis ')'
> #98: FILE: hw/9pfs/9p.c:592:
> +           ((uint64_t)mirror8bit((value >> 48) & 0xff) << 8 ) |
> 
> ERROR: space prohibited before that close parenthesis ')'
> #99: FILE: hw/9pfs/9p.c:593:
> +           ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;
> 
> WARNING: Block comments use a leading /* on a separate line
> #102: FILE: hw/9pfs/9p.c:596:
> +/** @brief Parameter k for the Exponential Golomb algorihm to be used.
> 
> WARNING: Block comments use a leading /* on a separate line
> #121: FILE: hw/9pfs/9p.c:615:
> +/** @brief Exponential Golomb algorithm for arbitrary k (including k=0).
> 
> WARNING: Block comments use a leading /* on a separate line
> #148: FILE: hw/9pfs/9p.c:642:
> +/** @brief Converts a suffix into a prefix, or a prefix into a suffix.
> 
> ERROR: "foo* bar" should be "foo *bar"
> #158: FILE: hw/9pfs/9p.c:652:
> +static VariLenAffix invertAffix(const VariLenAffix* affix)
> 
> WARNING: line over 80 characters
> #161: FILE: hw/9pfs/9p.c:655:
> +        .type = (affix->type == AffixType_Suffix) ? AffixType_Prefix : AffixType_Suffix,
> 
> WARNING: line over 80 characters
> #162: FILE: hw/9pfs/9p.c:656:
> +        .value =  mirror64bit(affix->value) >> ((sizeof(affix->value) * 8) - affix->bits),
> 
> WARNING: Block comments use a leading /* on a separate line
> #167: FILE: hw/9pfs/9p.c:661:
> +/** @brief Generates suffix numbers with "suffix-free" property.
> 
> WARNING: Block comments use a leading /* on a separate line
> #246: FILE: hw/9pfs/9p.c:752:
> +/** @brief Slow / full mapping host inode nr -> guest inode nr.
> 
> WARNING: Block comments use a leading /* on a separate line
> #300: FILE: hw/9pfs/9p.c:805:
> +/** @brief Quick mapping host inode nr -> guest inode nr.
> 
> ERROR: spaces required around that '-' (ctx:VxV)
> #348: FILE: hw/9pfs/9p.c:849:
> +        .ino_prefix = (uint16_t) (stbuf->st_ino >> (64-ino_hash_bits))
>                                                        ^
> 
> WARNING: Block comments use a leading /* on a separate line
> #429: FILE: hw/9pfs/9p.h:244:
> +/** @brief Unique affix of variable length.
> 
> ERROR: line over 90 characters
> #442: FILE: hw/9pfs/9p.h:257:
> +    int bits; /* Lenght of the affix, that is how many (of the lowest) bits of @c value must be used for appending/prepending this affix to its final resulting, unique number. */
> 
> ERROR: line over 90 characters
> #448: FILE: hw/9pfs/9p.h:263:
> +    int prefix_bits; /* How many (high) bits of the original inode number shall be used for hashing. */
> 
> total: 8 errors, 9 warnings, 386 lines checked
> 
> Patch 4/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/cover.1566503584.git.qemu_oss@crudebyte.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

