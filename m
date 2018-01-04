Received: from eggs.gnu.org ([2001:4830:134:3::10]:60858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eX1jK-0005Zh-F8
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 04:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eX1jH-0002mz-8f
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 04:22:30 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:51469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eX1jG-0002kD-UR
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 04:22:27 -0500
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
	<446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
	<1548618960.818551.1515050828217.JavaMail.zimbra@oxygem.tv>
	<cb656289-97ee-d45e-cfcc-51e86b9a11ce@profihost.ag>
	<130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <7e2d2768-fe40-c87a-cd91-1b9a60da8771@profihost.ag>
Date: Thu, 4 Jan 2018 10:22:24 +0100
MIME-Version: 1.0
In-Reply-To: <130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Am 04.01.2018 um 09:35 schrieb Alexandre DERUMIER:
>>> So you need: 
>>> 1.) intel / amd cpu microcode update 
>>> 2.) qemu update to pass the new MSR and CPU flags from the microcode update 
>>> 3.) host kernel update 
>>> 4.) guest kernel update 
> 
> are you sure we need to patch guest kernel if we are able to patch qemu ?
>> I have some pretty old guest (linux and windows)
>
> If I understand, patching the host kernel, should avoid that a vm is reading memory of another vm.
> (the most critical)

Yes - this was just to complete the mitigation on all layers.

> 
> patching the guest kernel, to avoid that a process from the vm have access to memory of another process of same vm.
Yes.

Stefan

> 
> 
> 
> ----- Mail original -----
> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
> À: "aderumier" <aderumier@odiso.com>
> Cc: "qemu-devel" <qemu-devel@nongnu.org>
> Envoyé: Jeudi 4 Janvier 2018 09:17:41
> Objet: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
> 
> Am 04.01.2018 um 08:27 schrieb Alexandre DERUMIER: 
>> does somebody have a redhat account to see te content of: 
>>
>> https://access.redhat.com/solutions/3307851 
>> "Impacts of CVE-2017-5754, CVE-2017-5753, and CVE-2017-5715 to Red Hat Virtualization products" 
> 
> i don't have one but the content might be something like this: 
> https://www.suse.com/de-de/support/kb/doc/?id=7022512 
> 
> So you need: 
> 1.) intel / amd cpu microcode update 
> 2.) qemu update to pass the new MSR and CPU flags from the microcode update 
> 3.) host kernel update 
> 4.) guest kernel update 
> 
> The microcode update and the kernel update is publicly available but i'm 
> missing the qemu one. 
> 
> Greets, 
> Stefan 
> 
>> ----- Mail original ----- 
>> De: "aderumier" <aderumier@odiso.com> 
>> À: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag> 
>> Cc: "qemu-devel" <qemu-devel@nongnu.org> 
>> Envoyé: Jeudi 4 Janvier 2018 08:24:34 
>> Objet: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches 
>>
>>>> Can anybody point me to the relevant qemu patches? 
>>
>> I don't have find them yet. 
>>
>> Do you known if a vm using kvm64 cpu model is protected or not ? 
>>
>> ----- Mail original ----- 
>> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag> 
>> À: "qemu-devel" <qemu-devel@nongnu.org> 
>> Envoyé: Jeudi 4 Janvier 2018 07:27:01 
>> Objet: [Qemu-devel] CVE-2017-5715: relevant qemu patches 
>>
>> Hello, 
>>
>> i've seen some vendors have updated qemu regarding meltdown / spectre. 
>>
>> f.e.: 
>>
>> CVE-2017-5715: QEMU was updated to allow passing through new MSR and 
>> CPUID flags from the host VM to the CPU, to allow enabling/disabling 
>> branch prediction features in the Intel CPU. (bsc#1068032) 
>>
>> Can anybody point me to the relevant qemu patches? 
>>
>> Thanks! 
>>
>> Greets, 
>> Stefan 
>>
> 
