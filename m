Received: from eggs.gnu.org ([2001:4830:134:3::10]:60048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emeJO-0001qh-V5
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emeJL-0001Xs-2k
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:36:18 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4f824a36-5d4f-267d-2bcb-04e118117abe@virtuozzo.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-8-git-send-email-anton.nefedov@virtuozzo.com>
	<w51y3k4u97c.fsf@maestria.local.igalia.com>
	<4f824a36-5d4f-267d-2bcb-04e118117abe@virtuozzo.com>
Date: Fri, 16 Feb 2018 12:36:11 +0100
Message-ID: <w51tvuhkvys.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 7/8] file-posix: account
 discard operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On Mon 12 Feb 2018 05:19:57 PM CET, Anton Nefedov wrote:
>>> @@ -158,6 +158,11 @@ typedef struct BDRVRawState {
>>>       bool page_cache_inconsistent:1;
>>>       bool has_fallocate;
>>>       bool needs_alignment;
>>> +    struct {
>>> +        int64_t discard_nb_ok;
>>> +        int64_t discard_nb_failed;
>>> +        int64_t discard_bytes_ok;
>>> +    } stats;
>> 
>> Shouldn't this new structure be defined in a header file so other
>> drivers can use it? Or did you define it here because you don't see that
>> happening soon?
>> 
>
> I guess there's no reason to burden the common header files as long as
> it's not really used anywhere else.

Fair enough,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
