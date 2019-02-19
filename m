Received: from eggs.gnu.org ([209.51.188.92]:41787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gwDbM-0000TE-5J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gwDTs-0002K0-Kg
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:03:14 -0500
Date: Tue, 19 Feb 2019 22:03:04 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190219220304.6mtpg44yry252glj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-2-richardw.yang@linux.intel.com>
	<e59b0920-4698-a0d1-7990-77d9e2202f9b@redhat.com>
	<83037dad-5d57-2ebd-0038-27dd38975d3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83037dad-5d57-2ebd-0038-27dd38975d3f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] CODING_STYLE: specify the indent rule
 for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, imammedo@redhat.com, mjt@tls.msk.ru

On Tue, Feb 19, 2019 at 11:55:04AM -0600, Eric Blake wrote:
>On 2/19/19 11:34 AM, Philippe Mathieu-Daudé wrote:
>
>> 
>> What is still unclear is what to do when a function name is over 60
>> characters (you follow a library/API and can not shorten it), for example:
>> 
>> static void ccid_card_vscard_handle_message(PassthruState *card,
>>     const VSCMsgHeader *scr_msg_header);
>> 
>> What is the project guideline in this case?
>
>I don't know that we have an official guideline, but I've seen enough
>code doing that. I've also seen this style:
>
>static void long_func_name(
>    parameter one, parameter two)
>{
>    if (condition) {
>        call_some_really_long_name(
>            arg1,
>            arg2);
>    }
>
>where even the first argument is put at an indentation of 4 from the
>primary line.

We should put this style in the example too?

>
>-- 
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3226
>Virtualization:  qemu.org | libvirt.org

-- 
Wei Yang
Help you, Help me
