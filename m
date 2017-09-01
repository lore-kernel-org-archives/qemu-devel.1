Received: from eggs.gnu.org ([2001:4830:134:3::10]:47090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnjOW-0008R2-Pj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnjOT-0000y1-LX
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:41:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnjOT-0000wm-Fr
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:41:45 -0400
References: <1504250391-6353-1-git-send-email-thuth@redhat.com>
	<150425055972.204.8095890686679875127@b5667b65043c>
	<20170901092845.GF31680@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7149d2ad-2f4f-8b1a-496c-22b8a05e43d4@redhat.com>
Date: Fri, 1 Sep 2017 12:41:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170901092845.GF31680@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post about the release
 of version 2.10.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, mdroth@linux.vnet.ibm.com

On 01.09.2017 11:28, Daniel P. Berrange wrote:
> On Fri, Sep 01, 2017 at 12:22:41AM -0700, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Message-id: 1504250391-6353-1-git-send-email-thuth@redhat.com
>> Subject: [Qemu-devel] [qemu-web PATCH] Add a blog post about the release of version 2.10.0
>> Type: series
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>>
>> BASE=base
>> n=1
>> total=$(git log --oneline $BASE.. | wc -l)
>> failed=0
>>
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>>
>> commits="$(git log --format=%H --reverse $BASE..)"
>> for c in $commits; do
>>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>>         failed=1
>>         echo
>>     fi
>>     n=$((n+1))
>> done
>>
>> exit $failed
>> === TEST SCRIPT END ===
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> From https://github.com/patchew-project/qemu
>>  * [new tag]               patchew/1504250391-6353-1-git-send-email-thuth@redhat.com -> patchew/1504250391-6353-1-git-send-email-thuth@redhat.com
>> Switched to a new branch 'test'
>> b70b83ae5d Add a blog post about the release of version 2.10.0
>>
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/1: Add a blog post about the release of version 2.10.0...
>> ERROR: trailing whitespace
>> #60: FILE: _posts/2017-09-01-qemu-2-10-0.md:43:
>> + * s390: support for z14 CPU models and netboot/TFTP via CCW BIOS, $
>>
>> total: 1 errors, 0 warnings, 56 lines checked
> 
> While it is nice that it identified the trailing whitespace in this
> case, does it really make sense for the patchew to be running the
> checkpatch.pl from qemu.git, against patches to qemu-web.git ?
> 
> Perhaps it should skip patches with 'web' or 'qemu-web' in the
> [...]  part of the subject ?

+1

... and Paolo, could you maybe fix up that line when picking up the patch?

 Thanks,
  Thomas
