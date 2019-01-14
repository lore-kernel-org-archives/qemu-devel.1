Received: from eggs.gnu.org ([209.51.188.92]:51895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj32k-0003Qu-L5
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gj32j-0004Mr-Us
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:16:46 -0500
Date: Mon, 14 Jan 2019 15:16:36 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190114151636.630d4b31.cohuck@redhat.com>
In-Reply-To: <6e0d217f-3027-bff8-b9fd-13469e940c97@linux.ibm.com>
References: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
	<5a7e9130-30d1-84ad-0737-5023b718b99c@redhat.com>
	<54bc1f9c-e997-cb1b-77cb-0dce478fafdc@linux.ibm.com>
	<d4599c55-2d71-e1e9-ec7a-cffbc7d06abe@redhat.com>
	<20190109123037.7f51888f.cohuck@redhat.com>
	<fb665b3b-9bbf-e2bd-8618-b080d4c2453d@linux.ibm.com>
	<105c451b-6873-b7a9-1c3a-e3b8fe7d4af3@redhat.com>
	<20190109181302.2ac8b249@oc2783563651>
	<bbcfd6dd-38b8-5d98-ac4b-3b17d63983fe@redhat.com>
	<6e0d217f-3027-bff8-b9fd-13469e940c97@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: Implement hot plug/unplug
 of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, jjherne@linux.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, fiuczy@linux.ibm.com, alex.williamson@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On Thu, 10 Jan 2019 11:22:48 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >>> Can you extend this patch description a little bit, including what we
> >>> discussed here?  
> >>
> >> Maybe a short comment that explains why qdev_simple_device_unplug_cb()
> >> is appropriate as well (i.e. hits that closing the mdev's fd is what
> >> triggers the cleanup of the actual resources)? I personally go log
> >> digging only once I get desperate.  
> > 
> > I go digging if I can't find a public document on how it works ;)  
> 
> Which reminds me, I will also need to update the docs/vfio-ap.txt
> document.

So, I assume there will be a v2 with some documentation changes?
