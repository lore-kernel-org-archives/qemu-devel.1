Received: from eggs.gnu.org ([2001:4830:134:3::10]:49257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHVAd-0000cq-Rv
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cHVAX-00089m-QW
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cHVAX-00088O-Kg
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:29:53 -0500
References: <1481796182-12670-1-git-send-email-vlad.lungu@windriver.com>
	<eee151e4-7cb6-eb26-a125-65757ec84e2e@redhat.com>
	<8a50b7ac-84cf-1111-0361-b9541fa4e174@windriver.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff53b6f1-a373-a4ff-6144-a171151147b2@redhat.com>
Date: Thu, 15 Dec 2016 13:29:48 +0100
MIME-Version: 1.0
In-Reply-To: <8a50b7ac-84cf-1111-0361-b9541fa4e174@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2] multiboot: copy the cmdline verbatim,
 unescape module strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vlad Lungu <vlad.lungu@windriver.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, rth@twiddle.net



On 15/12/2016 12:34, Vlad Lungu wrote:
> 
> 
> On 12/15/2016 12:56 PM, Paolo Bonzini wrote:
>>
>> On 15/12/2016 11:03, Vlad Lungu wrote:
>>>  
>>>      if (initrd_filename) {
>>> -        char *next_initrd, not_last;
>>> +        char *next_initrd, not_last, tmpbuf[strlen(initrd_filename) + 1];
>>>  
>>>          mbs.offset_mods = mbs.mb_buf_size;
>>>  
>>> @@ -299,22 +299,24 @@ int load_multiboot(FWCfgState *fw_cfg,
>>>              next_initrd = (char *)get_opt_value(NULL, 0, initrd_filename);
>>>              not_last = *next_initrd;
>>>              *next_initrd = '\0';
>>> +            /* Unescape the filename + eventual arguments */
>>> +            get_opt_value(tmpbuf, strlen(initrd_filename) + 1, initrd_filename);
>> No need to call get_opt_value twice; you can call it once since you have
>> declared tmpbuf to hold the entire size of initrd_filename.
> So what you're saying is to go with
> 
>              next_initrd = (char *)get_opt_value(tmpbuf, sizeof(tmpbuf), initrd_filename);
> 
> and delete the second call to get_opt_value().
> 
> Is that right?

Yes, thanks!

Paolo
