Received: from eggs.gnu.org ([209.51.188.92]:37093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzlDE-0006Ti-Fi
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzlDC-0003j1-7h
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:40:40 -0500
References: <155145833243.7448.7712285846219985320@49fa7ef69f7b>
From: David Hildenbrand <david@redhat.com>
Message-ID: <65aa2ecc-6109-27b3-f81c-a9f9d6f32e4b@redhat.com>
Date: Fri, 1 Mar 2019 17:40:34 +0100
MIME-Version: 1.0
In-Reply-To: <155145833243.7448.7712285846219985320@49fa7ef69f7b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/32] s390x/tcg: Vector Instruction
 Support Part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, rth@twiddle.net

On 01.03.19 17:38, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190301115413.27153-1-david@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20190301115413.27153-1-david@redhat.com
> Subject: [Qemu-devel] [PATCH v2 00/32] s390x/tcg: Vector Instruction Support Part 1
> Type: series
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
>  t [tag update]            patchew/20190301115413.27153-1-david@redhat.com -> patchew/20190301115413.27153-1-david@redhat.com
> Switched to a new branch 'test'
> 0ac11c9c15 s390x/tcg: Implement VECTOR UNPACK *
> 5a49ebf4e8 s390x/tcg: Implement VECTOR STORE WITH LENGTH
> 4d3377c434 s390x/tcg: Implement VECTOR STORE MULTIPLE
> 8b7bef7bb1 s390x/tcg: Implement VECTOR STORE ELEMENT
> 4c1389d499 s390x/tcg: Implement VECTOR STORE
> f263bd5abf s390x/tcg: Provide probe_write helper
> 2656298ce4 s390x/tcg: Implement VECTOR SIGN EXTEND TO DOUBLEWORD
> 11a18a7c7a s390x/tcg: Implement VECTOR SELECT
> cfefe3b4e5 s390x/tcg: Implement VECTOR SCATTER ELEMENT
> d37e771f93 s390x/tcg: Implement VECTOR REPLICATE IMMEDIATE
> fe16a34aff s390x/tcg: Implement VECTOR REPLICATE
> 448206eac2 s390x/tcg: Implement VECTOR PERMUTE DOUBLEWORD IMMEDIATE
> b004b8aca7 s390x/tcg: Implement VECTOR PERMUTE
> 0eca96087e s390x/tcg: Implement VECTOR PACK *
> 89103d1726 s390x/tcg: Implement VECTOR MERGE (HIGH|LOW)
> 316ef22fe0 s390x/tcg: Implement VECTOR LOAD WITH LENGTH
> aaa23d4046 s390x/tcg: Implement VECTOR LOAD VR FROM GRS DISJOINT
> 2ad9c8af70 s390x/tcg: Implement VECTOR LOAD VR ELEMENT FROM GR
> 0cb0e0c8dd s390x/tcg: Implement VECTOR LOAD TO BLOCK BOUNDARY
> 8956d4b299 s390x/tcg: Implement VECTOR LOAD MULTIPLE
> 6b0215cba5 s390x/tcg: Implement VECTOR LOAD LOGICAL ELEMENT AND ZERO
> 0402a6b515 s390x/tcg: Implement VECTOR LOAD GR FROM VR ELEMENT
> 7e69c68810 s390x/tcg: Implement VECTOR LOAD ELEMENT IMMEDIATE
> a73099e2f3 s390x/tcg: Implement VECTOR LOAD ELEMENT
> 3b45e2cedc s390x/tcg: Implement VECTOR LOAD AND REPLICATE
> ee0c0fd7e9 s390x/tcg: Implement VECTOR LOAD
> 81b9dfde6a s390x/tcg: Implement VECTOR GENERATE MASK
> 46922b0da7 s390x/tcg: Implement VECTOR GENERATE BYTE MASK
> 03b3fe255d s390x/tcg: Implement VECTOR GATHER ELEMENT
> ebd9dced4a s390x/tcg: Utilities for vector instruction helpers
> 85dff107e2 s390x/tcg: Check vector register instructions at central point
> 3c063a0270 s390x/tcg: Define vector instruction formats
> 
> === OUTPUT BEGIN ===
> 1/32 Checking commit 3c063a027075 (s390x/tcg: Define vector instruction formats)
> 2/32 Checking commit 85dff107e233 (s390x/tcg: Check vector register instructions at central point)
> 3/32 Checking commit ebd9dced4a4a (s390x/tcg: Utilities for vector instruction helpers)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #30: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 128 lines checked
> 
> Patch 3/32 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/32 Checking commit 03b3fe255d38 (s390x/tcg: Implement VECTOR GATHER ELEMENT)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #56: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 155 lines checked
> 
> Patch 4/32 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 5/32 Checking commit 46922b0da75e (s390x/tcg: Implement VECTOR GENERATE BYTE MASK)
> 6/32 Checking commit 81b9dfde6a3e (s390x/tcg: Implement VECTOR GENERATE MASK)
> 7/32 Checking commit ee0c0fd7e940 (s390x/tcg: Implement VECTOR LOAD)
> 8/32 Checking commit 3b45e2cedc0a (s390x/tcg: Implement VECTOR LOAD AND REPLICATE)
> 9/32 Checking commit a73099e2f39b (s390x/tcg: Implement VECTOR LOAD ELEMENT)
> 10/32 Checking commit 7e69c6881091 (s390x/tcg: Implement VECTOR LOAD ELEMENT IMMEDIATE)
> 11/32 Checking commit 0402a6b515d0 (s390x/tcg: Implement VECTOR LOAD GR FROM VR ELEMENT)
> 12/32 Checking commit 6b0215cba533 (s390x/tcg: Implement VECTOR LOAD LOGICAL ELEMENT AND ZERO)
> 13/32 Checking commit 8956d4b299a9 (s390x/tcg: Implement VECTOR LOAD MULTIPLE)
> 14/32 Checking commit 0cb0e0c8dd60 (s390x/tcg: Implement VECTOR LOAD TO BLOCK BOUNDARY)
> 15/32 Checking commit 2ad9c8af7091 (s390x/tcg: Implement VECTOR LOAD VR ELEMENT FROM GR)
> 16/32 Checking commit aaa23d40467f (s390x/tcg: Implement VECTOR LOAD VR FROM GRS DISJOINT)
> 17/32 Checking commit 316ef22fe0bf (s390x/tcg: Implement VECTOR LOAD WITH LENGTH)
> 18/32 Checking commit 89103d17261b (s390x/tcg: Implement VECTOR MERGE (HIGH|LOW))
> 19/32 Checking commit 0eca96087ec5 (s390x/tcg: Implement VECTOR PACK *)
> ERROR: space prohibited between function name and open parenthesis '('
> #182: FILE: target/s390x/vec_helper.c:123:
> +typedef uint##TBITS##_t (*vpk##BITS##_fn)(uint##BITS##_t, int *);              \
> 
> total: 1 errors, 0 warnings, 245 lines checked
> 
> Patch 19/32 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 20/32 Checking commit b004b8aca79d (s390x/tcg: Implement VECTOR PERMUTE)
> WARNING: line over 80 characters
> #21: FILE: target/s390x/helper.h:143:
> +DEF_HELPER_FLAGS_5(gvec_vperm, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, cptr, i32)
> 
> total: 0 errors, 1 warnings, 58 lines checked
> 
> Patch 20/32 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 21/32 Checking commit 448206eac2f5 (s390x/tcg: Implement VECTOR PERMUTE DOUBLEWORD IMMEDIATE)
> 22/32 Checking commit fe16a34aff9b (s390x/tcg: Implement VECTOR REPLICATE)
> 23/32 Checking commit d37e771f93e0 (s390x/tcg: Implement VECTOR REPLICATE IMMEDIATE)
> 24/32 Checking commit cfefe3b4e519 (s390x/tcg: Implement VECTOR SCATTER ELEMENT)
> 25/32 Checking commit 11a18a7c7a67 (s390x/tcg: Implement VECTOR SELECT)
> 26/32 Checking commit 2656298ce402 (s390x/tcg: Implement VECTOR SIGN EXTEND TO DOUBLEWORD)
> 27/32 Checking commit f263bd5abf8b (s390x/tcg: Provide probe_write helper)
> 28/32 Checking commit 4c1389d499cb (s390x/tcg: Implement VECTOR STORE)
> 29/32 Checking commit 8b7bef7bb18e (s390x/tcg: Implement VECTOR STORE ELEMENT)
> 30/32 Checking commit 4d3377c434cd (s390x/tcg: Implement VECTOR STORE MULTIPLE)
> 31/32 Checking commit 5a49ebf4e884 (s390x/tcg: Implement VECTOR STORE WITH LENGTH)
> 32/32 Checking commit 0ac11c9c1553 (s390x/tcg: Implement VECTOR UNPACK *)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190301115413.27153-1-david@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

Yes Patchew, I get it, no need to resend 10 times :D

Seriously, one false positive and other stuff that is to be ignored.

-- 

Thanks,

David / dhildenb
