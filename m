Received: from eggs.gnu.org ([2001:4830:134:3::10]:42316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRL6b-0008RX-Hy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fRL6a-00077P-QI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:23:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fRL6a-00076x-Kr
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:23:16 -0400
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
	<20180608020724-mutt-send-email-mst@kernel.org>
	<5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
	<20180608190040-mutt-send-email-mst@kernel.org>
	<CAFEAcA-h3xxeRFO32pnqrwR_wZ1=us-t0FunS2aJRpQV==3-GQ@mail.gmail.com>
	<20180608192148-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <74b8eaa6-841f-1e35-654f-ba0243970958@redhat.com>
Date: Fri, 8 Jun 2018 19:23:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180608192148-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH 2/5] acpi: "make check" should fail on
 asl mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>

On 08.06.2018 18:24, Michael S. Tsirkin wrote:
> On Fri, Jun 08, 2018 at 05:16:30PM +0100, Peter Maydell wrote:
>> On 8 June 2018 at 17:03, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> Pull requests are somewhat different, they are usually tested for lack
>>> of warnings. This change didn't arrive as a result of a pull request
>>> maybe that's why it slipped through the cracks. Peter?
>>>
>>> Maybe we need a "pedantic" flag to fail on any warnings, or just catch
>>> output to stderr.
>>
>> If there's a situation that shouldn't exist in the tree (ie
>> a bug), then make check should catch it, and result in a
>> failure, not just printing random stuff to stderr. Otherwise
>> I'm not going to notice it, whether I'm applying a pull request
>> or an individual patch.
>>
>> thanks
>> -- PMM
> 
> It's ok if it happens, but it just makes debugging and reviewing
> ACPI patches a little bit harder until it's fixed.

It's maybe ok for *you*, but this certainly confuses everybody else. If
I want to check my patches and suddenly some strange warnings are
popping up, I first assume that there is something wrong in my patches
(since I assume that the git repository is clean by default). So I've
got to waste my time debugging issues that are not my own. Thanks for
that :-/

 Thomas
