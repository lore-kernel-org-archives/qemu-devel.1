Received: from eggs.gnu.org ([2001:4830:134:3::10]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eC0sE-0006rh-Vr
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eC0sE-00068S-2T
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:12:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<ad7c1de551fbc497743e4dd60335a75cb5365a15.1508390588.git.alistair.francis@xilinx.com>
	<87efpmccvu.fsf@secure.laptop>
Date: Tue, 07 Nov 2017 11:12:14 +0100
In-Reply-To: <87efpmccvu.fsf@secure.laptop> (Juan Quintela's message of "Sun,
	29 Oct 2017 14:16:53 +0100")
Message-ID: <87bmke4cu9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 01/46] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, alistair23@gmail.com, Aurelien Jarno <aurelien@aurel32.net>

Juan Quintela <quintela@redhat.com> writes:

> Alistair Francis <alistair.francis@xilinx.com> wrote:
>> Replace all occurs of __FUNCTION__ except for the check in checkpatch
>> with the non GCC specific __func__.
>>
>> One line in hcd-musb.c was manually tweaked to pass checkpatch.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Andrzej Zaborowski <balrogg@gmail.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Anthony Perard <anthony.perard@citrix.com>
>> Cc: John Snow <jsnow@redhat.com>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
>> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Fam Zheng <famz@redhat.com>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: qemu-arm@nongnu.org
>> Cc: qemu-block@nongnu.org
>> Cc: xen-devel@lists.xenproject.org
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>
>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>> index 5bcb1c60e1..543b1bd8d5 100644
>> --- a/audio/audio_int.h
>> +++ b/audio/audio_int.h
>> @@ -253,7 +253,7 @@ static inline int audio_ring_dist (int dst, int src, int len)
>>  #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
>>  
>>  #if defined _MSC_VER || defined __GNUC__
>> -#define AUDIO_FUNC __FUNCTION__
>> +#define AUDIO_FUNC __func__
>>  #else
>>  #define AUDIO_FUNC __FILE__ ":" AUDIO_STRINGIFY (__LINE__)
>>  #endif
>
> Unrelated to this patch ....
> Do we really support other compilers than msc and gcc?

Let me rephrase the question: do we really support compilers that don't
understand __func__?  The presence of numerous unconditional uses of
__func__ in the tree means the answer is no.  Let's replace AUDIO_FUNC
by plain __func__.
