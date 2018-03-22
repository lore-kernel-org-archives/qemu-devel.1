Received: from eggs.gnu.org ([2001:4830:134:3::10]:40236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5eA-0007OP-DU
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez5e9-0007ew-Gb
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:13:10 -0400
References: <20180322161226.29796-1-lvivier@redhat.com>
	<152174145840.240.3926671265619235661@71c20359a636>
	<CAFEAcA_Uxhrh2L+FghG7y2r7n36rfo41jKw9vdGZYo32nk28cg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6137f1be-98a0-1b3f-6bed-ca94be1b5d1a@redhat.com>
Date: Thu, 22 Mar 2018 14:12:41 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Uxhrh2L+FghG7y2r7n36rfo41jKw9vdGZYo32nk28cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] coccinelle: re-run scripts from
 scripts/coccinelle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Graf <agraf@suse.de>, Max Filippov <jcmvbkbc@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 03/22/2018 01:00 PM, Peter Maydell wrote:
> On 22 March 2018 at 17:57,  <no-reply@patchew.org> wrote:
>> Checking PATCH 4/4: Remove unnecessary variables for function return value...
>> ERROR: return is not a function, parentheses are not required
>> #251: FILE: target/mips/dsp_helper.c:3281:
>> +    return (temp[1] << 63) | (temp[0] >> 1);
> 
> This looks like a bug in checkpatch. I guess to fix it you'd need
> to make checkpatch count opening and closing parens in the line
> to see if it goes to 0 somewhere other than just before the ';'...

Or if we don't patch the false negative, you can bypass checkpatch with 
an ugly hack:

return 0 + (...) | (...);

(I'm NOT going to do that bypass - it's too ugly for my taste)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
