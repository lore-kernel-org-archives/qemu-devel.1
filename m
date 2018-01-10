Received: from eggs.gnu.org ([2001:4830:134:3::10]:59559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGVn-0000Wl-Ld
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGVm-0005k8-MO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:33:47 -0500
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<CAFEAcA-Mzyf2S3yW04LNVy7pAZ6gmzXo3aiFdPxrbWAAAX7N0Q@mail.gmail.com>
	<20180110015506.GO2131@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b3ef6d4-0e2f-686a-a1ce-8f71ab1e10d4@redhat.com>
Date: Wed, 10 Jan 2018 14:33:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180110015506.GO2131@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: surajjs@au1.ibm.com, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On 10/01/2018 02:55, David Gibson wrote:
> On Tue, Jan 09, 2018 at 03:15:25PM +0000, Peter Maydell wrote:
>> On 9 January 2018 at 12:16, David Gibson <david@gibson.dropbear.id.au> wrote:
>>> Thanks.  Even if you can identify which patch it is and we can
>>> postpone that one would be a bug help.
>>
>> Bisection blames this one:
>>
>> pbonzini@redhat.com (1):
>>       target-ppc: optimize cmp translation
> 
> Aha!  Ok, I'll pull that one out until we find a fix.

Richard posted one, it's an ARM32 backend bug.

> [snip]
>> (This is a build for arm32, running in a chroot on an aarch64
>> box, non-debug build.)
> 
> Ah.. but since it's a chroot, still an aarch64 cpu behind it all.

No, it's running 32-bit ARM code.

Paolo

  I
> think the machines I managed to borrow were all much older slower
> really truly arm32 machines, which I guess didn't show the problem.
> 
> Oh.. and probably a debug (default) build as well.
> 
