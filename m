Received: from eggs.gnu.org ([2001:4830:134:3::10]:58387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQyIL-0004a1-25
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQyIJ-0006wn-WA
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 13:01:53 -0400
References: <152837465974.447.3394605257699992372@d39dc562802a>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2b5c36fb-1c71-e7b2-bf96-30b5a747d20d@redhat.com>
Date: Thu, 7 Jun 2018 19:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <152837465974.447.3394605257699992372@d39dc562802a>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] pc-bios/s390-ccw: Allow network
 booting via pxelinux.cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.vnet.ibm.com, alifm@linux.ibm.com, walling@linux.ibm.com, cohuck@redhat.com

On 07.06.2018 14:31, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 1528374154-14680-1-git-send-email-thuth@redhat.com
> Subject: [Qemu-devel] [PATCH v2 0/4] pc-bios/s390-ccw: Allow network booting via pxelinux.cfg
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
> From https://github.com/patchew-project/qemu
>    5d328d7d2f..8e36d27c5a  master     -> master
>  * [new tag]               patchew/1528374154-14680-1-git-send-email-thuth@redhat.com -> patchew/1528374154-14680-1-git-send-email-thuth@redhat.com
>  * [new tag]               patchew/1528403460-30526-1-git-send-email-gengdongjiu@huawei.com -> patchew/1528403460-30526-1-git-send-email-gengdongjiu@huawei.com
>  t [tag update]            patchew/20180530180120.13355-1-richard.henderson@linaro.org -> patchew/20180530180120.13355-1-richard.henderson@linaro.org
> Switched to a new branch 'test'
> 132ffa3587 pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the UUID
> b3b73613ba pc-bios/s390-ccw/net: Add support for pxelinux-style config files
> 699020402a pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
> 5dd76a9c89 roms: Update SLOF submodule to current status
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/4: roms: Update SLOF submodule to current status...
> Checking PATCH 2/4: pc-bios/s390-ccw/net: Update code for the latest changes in SLOF...
> Checking PATCH 3/4: pc-bios/s390-ccw/net: Add support for pxelinux-style config files...
> Checking PATCH 4/4: pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the UUID...
> ERROR: space prohibited before open square bracket '['
> #57: FILE: pc-bios/s390-ccw/netmain.c:267:
> +                 : [cc] "=d" (cc)

Patchew obviously does not know about inline assembly ... I think I
prefer to keep the space here.

 Thomas
