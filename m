Received: from eggs.gnu.org ([2001:4830:134:3::10]:37120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHSav-0000hw-Ta
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHSar-0006Dc-1I
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:44:57 -0500
Received: from mail.windriver.com ([147.11.1.11]:57955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Vlad.Lungu@windriver.com>)
	id 1cHSaq-0006Br-Lb
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:44:52 -0500
References: <1481732391-882-1-git-send-email-vlad.lungu@windriver.com>
	<ef1f3b2a-d206-7082-3227-423e0d9d9619@redhat.com>
	<20161214170058.GJ3808@thinpad.lan.raisama.net>
	<abea10db-9da8-d6eb-c6eb-67817b1fadda@redhat.com>
	<20161214175144.GN3808@thinpad.lan.raisama.net>
	<1509132582.4065072.1481751487408.JavaMail.zimbra@redhat.com>
	<20161214222601.GP3808@thinpad.lan.raisama.net>
	<458039301.4070513.1481754729324.JavaMail.zimbra@redhat.com>
From: Vlad Lungu <vlad.lungu@windriver.com>
Message-ID: <6c53d8e4-292d-26de-3d05-bf323ab4fa70@windriver.com>
Date: Thu, 15 Dec 2016 11:44:46 +0200
MIME-Version: 1.0
In-Reply-To: <458039301.4070513.1481754729324.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net



On 12/15/2016 12:32 AM, Paolo Bonzini wrote:
>>>> In other words: this fixes the mb_add_cmdline(kcmdline) case, and
>>>> doesn't break comma escaping on the initrd case (because it was
>>>> already broken). I don't see a problem with this patch.
>>> ... there is one case of comma escaping that wasn't broken:
>>>
>>>     $ qemu-system-x86_64 -kernel foo -initrd '/tmp/one
>>>     arg,,with,,commas,/tmp/another arg,,with,,commas'
>>>
>> Oh, I didn't notice the whitespace-based split for initrd
>> arguments.
So that's how it works :-)
>> This is messier than I thought. Maybe the simplest solution is to
>> inline mb_add_cmdline() at both callers, and change the kcmdline
>> one to use memcpy().
>

OK, I have a new version that does with memcpy for the cmdline, with
get_opt_value() for the modules and also unescapes the filename for
get_image_size()/load_image() . You still can't have spaces in filenames,
so maybe a new scheme should be devised for this.

Regards,
Vlad
