Received: from eggs.gnu.org ([2001:4830:134:3::10]:53480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkTxO-0001OJ-8s
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkTxL-0000Fc-3r
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:40:54 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkTxK-0000Ey-Ov
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:40:51 -0400
References: <153303988145.29412.13761534940635173122@502c9da6d61e>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <48b6bd17-feff-5f4b-05a7-4bc2370ea212@vivier.eu>
Date: Tue, 31 Jul 2018 14:40:28 +0200
MIME-Version: 1.0
In-Reply-To: <153303988145.29412.13761534940635173122@502c9da6d61e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, riku.voipio@iki.fi, alex.bennee@linaro.org

Le 31/07/2018 à 14:24, no-reply@patchew.org a écrit :
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180731084203.29959-1-laurent@vivier.eu
> Subject: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 806398c875 linux-user: ppc64: don't use volatile register during safe_syscall
> ba78346662 tests: add check_invalid_maps to test-mmap
> 80fc1be868 linux-user/mmap.c: handle invalid len maps correctly
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/3: linux-user/mmap.c: handle invalid len maps correctly...
> Checking PATCH 2/3: tests: add check_invalid_maps to test-mmap...
> ERROR: code indent should never use tabs
> #62: FILE: tests/tcg/multiarch/test-mmap.c:498:
> +^Icheck_invalid_mmaps();$
> 
> total: 1 errors, 0 warnings, 40 lines checked

I'm going to resend a pull request without the tab.

Thanks,
Laurent
