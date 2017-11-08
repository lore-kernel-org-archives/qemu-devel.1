Received: from eggs.gnu.org ([2001:4830:134:3::10]:35768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCLAg-0002FG-Ku
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eCLAf-0000MH-C0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:53:14 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<ad7c1de551fbc497743e4dd60335a75cb5365a15.1508390588.git.alistair.francis@xilinx.com>
	<87efpmccvu.fsf@secure.laptop> <87bmke4cu9.fsf@dusky.pond.sub.org>
	<51d103e9-8d6b-8c83-dd69-effe997d4813@redhat.com>
Date: Wed, 08 Nov 2017 08:52:51 +0100
In-Reply-To: <51d103e9-8d6b-8c83-dd69-effe997d4813@redhat.com> (Eric Blake's
	message of "Tue, 7 Nov 2017 13:41:49 -0600")
Message-ID: <87shdptdf0.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, alistair23@gmail.com, Alistair Francis <alistair.francis@xilinx.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Eric Blake <eblake@redhat.com> writes:

> On 11/07/2017 04:12 AM, Markus Armbruster wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>> 
>>> Alistair Francis <alistair.francis@xilinx.com> wrote:
>>>> Replace all occurs of __FUNCTION__ except for the check in checkpatch
>>>> with the non GCC specific __func__.
>>>>
>
>>>> +++ b/audio/audio_int.h
>>>> @@ -253,7 +253,7 @@ static inline int audio_ring_dist (int dst, int src, int len)
>>>>  #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
>>>>  
>>>>  #if defined _MSC_VER || defined __GNUC__
>>>> -#define AUDIO_FUNC __FUNCTION__
>>>> +#define AUDIO_FUNC __func__
>>>>  #else
>>>>  #define AUDIO_FUNC __FILE__ ":" AUDIO_STRINGIFY (__LINE__)
>>>>  #endif
>>>
>>> Unrelated to this patch ....
>>> Do we really support other compilers than msc and gcc?
>> 
>> Let me rephrase the question: do we really support compilers that don't
>> understand __func__?  The presence of numerous unconditional uses of
>> __func__ in the tree means the answer is no.  Let's replace AUDIO_FUNC
>> by plain __func__.
>
> Answered elsewhere in patch 3/46 (where we DO replace AUDIO_FUNC by
> __func__).

I see.

Put 03/46 first, so we don't have to mess with AUDIO_FUNC twice?
