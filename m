Received: from eggs.gnu.org ([2001:4830:134:3::10]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eornW-0008Mg-JD
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eornV-000896-PO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:24:34 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-11-kwolf@redhat.com>
	<53e504b6-cb8e-e261-e7b9-c2ea9453621b@redhat.com>
	<20180222095042.GA4147@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6af497b2-9bc0-9ee0-4b88-429c0ddc7af1@redhat.com>
Date: Thu, 22 Feb 2018 08:24:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180222095042.GA4147@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/36] test-qemu-opts: Test
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/22/2018 03:50 AM, Kevin Wolf wrote:

>>> +    opts = qemu_opts_parse(&opts_list_01, "str1=foo,str2=,str3=bar,number1=42",
>>> +                           false, &error_abort);
>>
>> Worth any additional craziness in regards to our QemuOpts parsing, like
>> str1=foo,,bar,str2... for an option containing commas, or str2=,str1=foo,
>> for supplying options in a different order than the list?  But what you have
>> is a good addition even if you don't tweak it.
> 
> This is not a test for parsing options string, but for converting an
> already existing QemuOpts to a QDict. Parsing is already extensively
> tested in /qemu-opts/opts_parse/*. I'm only using qemu_opts_parse() here
> because it's the most convenient way to create a QemuOpts with multiple
> options.
> 
> So the only things we need to consider in this test case are different
> QemuOpts that result from the parsing. Escaped commas don't exist in
> this representation any more and the associated QemuOptsList isn't
> involved in the conversion to QDicts, so these wouldn't actually be new
> cases for the thing we're testing here.

Alright, you've convinced me that this isn't the test to be hammering on 
QemuOpts.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
