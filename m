Received: from eggs.gnu.org ([2001:4830:134:3::10]:50421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eMKGv-0005Em-I3
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eMKGr-0001nY-LP
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:56:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41336
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eMKGr-0001nM-FP
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:56:53 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5KumPl056964
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 15:56:51 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ep2j1h18r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 15:56:51 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 13:56:50 -0700
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CKE1-ApZ9MF2njB-0yiaszqJFZPVTfGQHg0YYgsuhwhnw@mail.gmail.com>
	<d670c086-f0f8-8906-795e-80345ec8475a@linux.vnet.ibm.com>
	<CAJ+F1C+4Ab_+DpUNbEf+kZPZ=T26tA0tNxQD4JWpc1+mmiKK-A@mail.gmail.com>
	<1510736731.4383.4.camel@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 15:56:46 -0500
MIME-Version: 1.0
In-Reply-To: <1510736731.4383.4.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <24cf3bb4-546d-0566-cffa-1b863d387db3@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 1/3] tpm_emulator: Add a
 caching layer for the TPM Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 11/15/2017 04:05 AM, Valluri, Amarnath wrote:
> On Wed, 2017-11-15 at 04:47 +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Wed, Nov 15, 2017 at 2:16 AM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>> On 11/14/2017 06:40 PM, Marc-Andr=C3=A9 Lureau wrote:
>>>>
>>>> Hi
>>>>
>>>> On Tue, Nov 14, 2017 at 10:52 PM, Stefan Berger
>>>> <stefanb@linux.vnet.ibm.com> wrote:
>>>>>
>>>>> Add a caching layer for the TPM established flag so that we
>>>>> don't
>>>>> need to go to the emulator every time the flag is read by
>>>>> accessing
>>>>> the REG_ACCESS register.
>>>> What's the impact? Isn't this just a "small" optimization? Iotw,
>>>> why
>>>> is this for-2.11?
>>> The TIS has a register that contains this flag and that's being
>>> polled quite
>>> frequently. So it generates a lot of traffic to the emulator. This
>>> caching
>>> layer gets rid of most of the traffic.
>> I didn't notice any problem when doing my tests, I guess Amarnath
>> niether. perhaps it's best to delay for after 2.11.
> Yes, I could see there is little frequent(21 calls to backend) to get
> establish flag, and this patch will help to avoid them. But i still
> agree with Marc and tag this as "small" optimization.

Can you review it so we have it ready for 2.12?

   Thanks,
       Stefan

>
> - Amarnath
