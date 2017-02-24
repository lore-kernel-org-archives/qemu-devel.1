Received: from eggs.gnu.org ([2001:4830:134:3::10]:52670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ch4rU-00067M-A3
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 20:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ch4rQ-0007eS-BO
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 20:39:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ch4rQ-0007eJ-5E
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 20:39:52 -0500
References: <20161215200509.2239-1-dgilbert@redhat.com>
	<20161215200509.2239-3-dgilbert@redhat.com>
	<20161216121906.GC2642@work-vm>
	<65721110-904C-4A02-9BFF-6FA5764E4F5D@daynix.com>
	<20170103194014.GH2340@work-vm>
	<2A82C6AD-1B33-45AC-9B33-B844FACDB478@daynix.com>
	<20170131194415.GO2395@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4b0898cb-b271-f09a-ef35-b6ac1cdda360@redhat.com>
Date: Fri, 24 Feb 2017 09:39:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170131194415.GO2395@work-vm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vmxnet3: VMStatify rx/tx q_descr and
 int_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, amit.shah@redhat.com



On 2017=E5=B9=B402=E6=9C=8801=E6=97=A5 03:44, Dr. David Alan Gilbert wrot=
e:
> * Dmitry Fleytman (dmitry@daynix.com) wrote:
>>> On 3 Jan 2017, at 21:40 PM, Dr. David Alan Gilbert<dgilbert@redhat.co=
m>  wrote:
>>>
>>> * Dmitry Fleytman (dmitry@daynix.com  <mailto:dmitry@daynix.com>) wro=
te:
>>>>> On 16 Dec 2016, at 14:19 PM, Dr. David Alan Gilbert<dgilbert@redhat=
.com>  wrote:
>>>>>
>>>>> * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
>>>>>> From: "Dr. David Alan Gilbert"<dgilbert@redhat.com>
>>>>>>
>>>>>> Fairly simple mechanical conversion of all fields.
>>>>>>
>>>>>> TODO!!!!
>>>>>> The problem is vmxnet3-ring size/cell_size/next are declared as si=
ze_t
>>>>>> but written as 32bit.
>>>>> Oops, I should have removed that warning in the commit message when
>>>>> I added the 1st patch in.
>>>>
>>>> Acked-by: Dmitry Fleytman<dmitry@daynix.com>
>>> Any reason for Acked-by rather than Reviewed-by ?
>>> Are you going to pull those?
>> Hi,
>>
>> There is no specific reason, the patch is OK as for me.
>> Reviewed-by: Dmitry Fleytman<dmitry@daynix.com>
>>
>> Jason, would you pick up this patch?
> Hi Jason,
>    Did you see ^^^^
>
> Dave
>

Applied to -net, thanks.
