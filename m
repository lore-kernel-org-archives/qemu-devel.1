Received: from eggs.gnu.org ([2001:4830:134:3::10]:49169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqBMV-00065O-Ri
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqBMV-0006Xh-5k
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 02:02:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <153430460784.10304.668502576933473446@502c9da6d61e>
	<91d64820-89d3-c0dc-741b-f6fb13175174@redhat.com>
Date: Thu, 16 Aug 2018 08:02:13 +0200
In-Reply-To: <91d64820-89d3-c0dc-741b-f6fb13175174@redhat.com> (Max Reitz's
	message of "Thu, 16 Aug 2018 02:01:44 +0200")
Message-ID: <87lg96g87u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 00/31] block: Fix some filename
 generation issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, berto@igalia.com, famz@redhat.com, qemu-block@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> On 2018-08-15 05:43, no-reply@patchew.org wrote:
>> Hi,
>> 
>> This series seems to have some coding style problems. See output below for
>> more information:
>
> [...]
>
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/31: block: Use bdrv_refresh_filename() to pull...
>> Checking PATCH 2/31: block: Use children list in bdrv_refresh_filename...
>> Checking PATCH 3/31: block: Skip implicit nodes for filename info...
>> Checking PATCH 4/31: block: Add BDS.auto_backing_file...
>> Checking PATCH 5/31: block: Respect backing bs in bdrv_refresh_filename...
>> ERROR: return is not a function, parentheses are not required
>> #46: FILE: block.c:5192:
>> +        return (bs->auto_backing_file[0] != '\0');
>> 
>> total: 1 errors, 0 warnings, 136 lines checked
>
> Sure, but I'd hate you personally if you omitted them.

@@
expression E;
@@
-    return (E);
+    return E;

You're welcome!
