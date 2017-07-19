Received: from eggs.gnu.org ([2001:4830:134:3::10]:41228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXp4q-0002x4-Lg
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXp4l-00021I-PO
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXp4l-00020x-Ii
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:31:39 -0400
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170719150313.6acdb087@gondolin>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bcdcdd89-4a1d-aa7c-ac2d-f994a0613183@redhat.com>
Date: Wed, 19 Jul 2017 15:31:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170719150313.6acdb087@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 19.07.2017 15:03, Cornelia Huck wrote:
> On Tue, 18 Jul 2017 16:24:46 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> Next try of the zPCI detangling, taking cpu models into account.
>>
>> The goal of this is twofold:
>> - Being able to disable PCI support in a build completely, as for v1.
>> - Properly fencing off PCI if the relevant facility bit is not provided.
>>
>> The second one leads to an interesting usability problem: -device help
>> still shows the various pci devices, but you cannot add them if the
>> cpu model does not include zpci, due to the phb not being instantiated.
>> The user is presented with
>>
>> qemu-system-s390x: -device virtio-rng-pci: No 'PCI' bus found for device 'virtio-rng-pci'
>>
>> ...which is not very helpful, as it does not point to the root cause (no
>> zpci in the cpu model, and therefore no pci at all). Not sure how one can
>> communicate this root cause, ideas welcome.
> 
> An idea on how to improve this would still be welcome :)

IMHO it's ok to keep that error message ... but we should add a section
to http://wiki.qemu.org/Documentation/Platforms/S390X about PCI devices,
including a sample error message as above and a note what has to be done
to get a machine with PCI support, so that people can find that page via
Google in case they run into this problem.

 Thomas
