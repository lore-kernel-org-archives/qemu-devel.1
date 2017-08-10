Received: from eggs.gnu.org ([2001:4830:134:3::10]:53517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dfjld-0008FZ-2T
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dfjlb-00081q-QQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:28:37 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:45588
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dfjlb-00081D-Hw
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:28:35 -0400
References: <1501575048-13485-1-git-send-email-frederic.konrad@adacore.com>
	<1501575048-13485-3-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA__hzcs_wvtYA35F4wAPhgHX0=-z8TJ8uwTSom6zxjN=A@mail.gmail.com>
	<086e70d6-d5c1-2879-874f-ea1804c6ab38@adacore.com>
	<20170801093015.GA4859@toto>
	<48d4b55f-6463-48a8-8ed3-b72110005377@adacore.com>
	<CAFEAcA_eWCEmXBGNJXAfUjgXwYX10FwxRwd_YNcdtMYXNLAROg@mail.gmail.com>
	<CAFEAcA-uR+KK9RfTQm8=E6SCeWh-CkY+fua-ByPUHoYQVw=TGQ@mail.gmail.com>
	<20170810092241.GK4859@toto>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <1e6243a1-90f9-786e-8095-b80294f00e22@adacore.com>
Date: Thu, 10 Aug 2017 11:28:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170810092241.GK4859@toto>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/2] xilinx-spips: add a migration
 blocker when using mmio_execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>



On 08/10/2017 11:22 AM, Edgar E. Iglesias wrote:
> On Thu, Aug 10, 2017 at 10:11:13AM +0100, Peter Maydell wrote:
>> On 1 August 2017 at 10:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 1 August 2017 at 10:35, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>>>>
>>>>
>>>> On 08/01/2017 11:30 AM, Edgar E. Iglesias wrote:
>>>>> At this stage, perhaps we should just register the blocker when this dev
>>>>> realizes.
>>>>>
>>>>> If a request_ptr comes in during migration, the VM will fail either way...
>>>
>>>> Yes but this will breaks migration for the spips device everytime
>>>> and not only when mmio-execution is used?
>>>
>>> This line of thought is why I ended up suggesting just disabling
>>> the exec-in-place feature -- that way we just don't introduce
>>> what would be a new-in-2.10 feature, rather than breaking something
>>> that used to work in 2.9.
>>
>> OK, so what's the plan here? We have several options:
>>   * just disable exec-from-spips for 2.10 (I sent a patch for that)
>>   * disable exec-from-spips for 2.10 but with a device x-property
>>     to allow the user to turn it on again if they really want it
>>   * this patch or variants on it which try to only disable
>>     migration if exec-from-spips is actually used by the guest
>>     (I don't like these because of the awkward corner cases if
>>     migration and the guest using exec-from-spips happen at the
>>     same time)
>>
>> So my current view remains "we should just disable this feature
>> for 2.10 and we can implement it properly with handling of
>> migration for 2.11", unless somebody cares enough to implement
>> the x-property thing within the next day or so.
> 
> Hi Peter,
> 
> I think the x-property sounds good.
> Fred, would you like to send a patch for that?
> Otherwise, I can do it later today.
> 
> Cheers,
> Edgar
> 

Hi,

Ok I will do.

Thanks,
Fred
