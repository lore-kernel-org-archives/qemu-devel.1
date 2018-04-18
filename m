Received: from eggs.gnu.org ([2001:4830:134:3::10]:57252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8mdm-0007Gj-FL
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8mdi-0001xZ-Kp
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:56:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8mdi-0001x4-Gg
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:56:46 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
	<b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
	<20180418122312.ebmd2nrtvk2h5e45@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f8c3945f-d2e7-e4a4-2b38-2736acd99e7c@redhat.com>
Date: Wed, 18 Apr 2018 14:56:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180418122312.ebmd2nrtvk2h5e45@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/18/18 14:23, Gerd Hoffmann wrote:
>   Hi,
> 
>> Hmmm, I'm not sure I agree. One use case is that you want a domain
>> config in which well-known OS-es, signed by the MS UEFI certs, just boot
>> with SB enabled. (Some of our internal folks really want this.)
>>
>> Another use case is that you want a domain in which SB *can* be enabled,
>> but your installer is signed with a different certificate chain (or it
>> is unsigned), and with *just* the MS certs enrolled, it wouldn't boot at
>> all. So you want the SB *feature*, but definitely not the initial
>> enrollment / SB *operational mode*.
> 
> So "secure-boot-enrolled-keys" also has SB turned on.

Yes.

>> For me to understand you better, are you suggesting merely that I:
>>
>> - rename @secure-boot-enrolled-keys to @enrolled-keys, and
>>
>> - drop the reference to @secure-boot from the end of the @enrolled-keys
>>   documentation paragraph? (Namely, "@secure-boot-enrolled-keys is only
>>   valid if the firmware also supports @secure-boot").
> 
> Yes.  So "secure-boot" specifies "firmware binary supports secure-boot"
> and "enrolled-keys" specifies "firmware nvram template has keys enrolled
> (and SB enabled).

OK.

> Other question:  Do we want allow to specify which certs/keys are
> enrolled?  Which would probably mean to drop "enrolled-keys" from
> features and make it an optional string instead,

Not an enum? "Microsoft" below should be an enum constant, shouldn't it?

> then specify
> "'enrolled-keys' : 'Microsoft'" in the json file.

If this is really necessary (up to Dan :) ), I'm down with it.

Thanks
Laszlo
