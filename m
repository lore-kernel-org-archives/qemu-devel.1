Received: from eggs.gnu.org ([2001:4830:134:3::10]:38168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSc5X-0007DF-32
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gSc5S-0007TE-65
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:15:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:60870 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gSc5R-0007Sc-VZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 01:15:38 -0500
References: <20181129100340.13823-1-fli@suse.com>
	<4031aa35-a9f0-dd87-ad2a-0cc35546f7af@redhat.com>
From: Fei Li <fli@suse.com>
Message-ID: <27e46dfa-f874-8b20-7522-f933d0dda897@suse.com>
Date: Fri, 30 Nov 2018 14:15:28 +0800
MIME-Version: 1.0
In-Reply-To: <4031aa35-a9f0-dd87-ad2a-0cc35546f7af@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1? RFC v2 0/5] fix some segmentation
 faults and migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>



On 11/29/2018 10:20 PM, Eric Blake wrote:
> On 11/29/18 4:03 AM, Fei Li wrote:
>> These five patches almost get the Reviewed-by and are extracted from
>> previous "[PATCH RFC v7 0/9] qemu_thread_create: propagate errors to
>> callers to check."=C2=A0 The mentioned patch series have waited on one
>> multifd issue for a while and still needs a further discussion.
>>
>> Thus separate(send) these five almost-done patches and hope they can
>> be merged for the next tag. Thanks for the review. :)
>
> How likely are any of these crashers to affect an end user?=20
IMHO, they are not easily triggered.
> Are any of them regressions over 3.0?
I do not think so.
> I'm trying to gauge if any of this is serious enough to warrant a=20
> -rc4, or if we are okay just documenting them as known corner-case=20
> bugs and deferring the fix to 4.0 and qemu-stable.
Emm, actually not so emergency to be included in -rc4.
And I think it is ok to wait for maintainers to do the pick for the=20
appropriate release.
BTW, why 4.0, but not 3.2 or 3.3 (I mean 3.minor version)?
> The fact that the series is still titled RFC is also an argument in=20
> favor of deferral.
Sorry that I forgot to remove the RFC..

Have a nice day, thanks :)
Fei
>
>>
>> v2:
>> - Update the commit message for patch 1/5, and get one more
>> =C2=A0=C2=A0 Reviewed-by.
>> - Get one Reviewed-by for patch 3/5.
>>
>>
>> Fei Li (5):
>> =C2=A0=C2=A0 Fix segmentation fault when qemu_signal_init fails
>> =C2=A0=C2=A0 qemu_thread_join: fix segmentation fault
>> =C2=A0=C2=A0 migration: fix the multifd code when receiving less chann=
els
>> =C2=A0=C2=A0 migration: remove unused &local_err parameter in multifd_=
save_cleanup
>> =C2=A0=C2=A0 migration: add more error handling for postcopy_ram_enabl=
e_notify
>
