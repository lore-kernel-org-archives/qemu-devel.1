Received: from eggs.gnu.org ([209.51.188.92]:50867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKynP-0003yA-4J
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKynN-0001ht-TV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:25:43 -0400
References: <155646780285.10667.18275282182893876584@c2072b67cc0c>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9c290579-45b2-88f5-2b1f-6af0db5a8e1f@redhat.com>
Date: Mon, 29 Apr 2019 07:25:15 +0200
MIME-Version: 1.0
In-Reply-To: <155646780285.10667.18275282182893876584@c2072b67cc0c>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] tests/qemu-iotests: Run basic
 iotests during "make check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, emaste@freebsd.org, qemu-block@nongnu.org, philmd@redhat.com, armbru@redhat.com, cfergeau@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, wainersm@redhat.com, lwhsu@freebsd.org

On 28/04/2019 18.10, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190428155451.15653-1-thuth@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20190428155451.15653-1-thuth@redhat.com
> Subject: [Qemu-devel] [PATCH v2 0/8] tests/qemu-iotests: Run basic iotests during "make check"
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
>  * [new tag]               patchew/20190428155451.15653-1-thuth@redhat.com -> patchew/20190428155451.15653-1-thuth@redhat.com
> Switched to a new branch 'test'
> 7bb09e08a3 tests: Run the iotests during "make check" again
> 3d905a091e tests/qemu-iotests/group: Re-use the "auto" group for tests that can always run
> 565003ac8a tests/qemu-iotests: Remove the "_supported_os Linux" line from many tests
> fb27dba3d9 cirrus / travis: Add gnu-sed and bash for macOS and FreeBSD
> 02ac8a4bf6 tests/qemu-iotests: Do not hard-code the path to bash
> 34c6a891ea tests/qemu-iotests/check: Pick a default machine if necessary
> d091edf7c1 tests/qemu-iotests/005: Add a sanity check for large sparse file support
> 3cf4caa193 tests/qemu-iotests: Fix output of qemu-io related tests
> 
> === OUTPUT BEGIN ===
> 1/8 Checking commit 3cf4caa193cc (tests/qemu-iotests: Fix output of qemu-io related tests)
> 2/8 Checking commit d091edf7c1ef (tests/qemu-iotests/005: Add a sanity check for large sparse file support)
> 3/8 Checking commit 34c6a891ea6e (tests/qemu-iotests/check: Pick a default machine if necessary)
> 4/8 Checking commit 02ac8a4bf608 (tests/qemu-iotests: Do not hard-code the path to bash)
> 5/8 Checking commit fb27dba3d9f0 (cirrus / travis: Add gnu-sed and bash for macOS and FreeBSD)
> 6/8 Checking commit 565003ac8a70 (tests/qemu-iotests: Remove the "_supported_os Linux" line from many tests)
> 7/8 Checking commit 3d905a091e64 (tests/qemu-iotests/group: Re-use the "auto" group for tests that can always run)
> ERROR: trailing whitespace
> #125: FILE: tests/qemu-iotests/group:115:
> +093 $

Not an error: The trailing whitespace is currently required for the
parsing code in the "check" script.

 Thomas
