Received: from eggs.gnu.org ([2001:4830:134:3::10]:44881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fqDN1-0003Rq-HD
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fqDMu-0002QV-58
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:11:01 -0400
Date: Thu, 16 Aug 2018 10:10:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180816101045.58e56d90.cohuck@redhat.com>
In-Reply-To: <153435752494.13634.12287809162339284939@502c9da6d61e>
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
	<153435752494.13634.12287809162339284939@502c9da6d61e>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Some improvements in z/Arch
 instructions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, pavel.zbitskiy@gmail.com, famz@redhat.com, qemu-s390x@nongnu.org, richard.henderson@linaro.org, david@redhat.com

On Wed, 15 Aug 2018 11:25:26 -0700 (PDT)
no-reply@patchew.org wrote:

> === OUTPUT BEGIN ===
> Checking PATCH 1/7: tests/tcg: add a simple s390x test...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #13: 
> new file mode 100644

tests/tcg/s390x/ does not seem to have a MAINTAINERS entry yet (it did
not contain anything interesting before, anyway.) Probably should be
added to the s390x/tcg section, as for the other architectures.

> 
> total: 0 errors, 1 warnings, 10 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 2/7: target/s390x: add BAL and BALR instructions...
> Checking PATCH 3/7: target/s390x: fix CSST decoding and runtime alignment check...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #72: 
> new file mode 100644
> 
> ERROR: space prohibited before open square bracket '['
> #98: FILE: tests/tcg/s390x/csst.c:22:
> +        : [op1] "+m" (op1),
> 
> ERROR: space prohibited before open square bracket '['
> #102: FILE: tests/tcg/s390x/csst.c:26:
> +        : [flags] "K" (0x0301),

Checkpatch often seems to have a hard time dealing with inline
assemblies. Probably best to just ignore the errors.
