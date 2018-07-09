Received: from eggs.gnu.org ([2001:4830:134:3::10]:40870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcdpn-0001QK-Fy
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcdpm-0004mA-Gd
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:36:39 -0400
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<20180709213131.GD7451@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <047ecdef-0faa-aac2-53fa-8a390fd33956@redhat.com>
Date: Mon, 9 Jul 2018 23:36:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180709213131.GD7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 09.07.2018 23:31, Eduardo Habkost wrote:
> On Mon, Jul 09, 2018 at 11:03:00PM +0200, Thomas Huth wrote:
>> When trying to "device_add bcm2837" on a machine that is not suitable for
>> this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":
>>
>> echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
>>  "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
>>  "'arguments': {'command-line': 'info qtree'}}" | \
>>  aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio
> 
> Interesting, how did you find this bug?

I was running some tests with an enhanced version of this patch applied:

http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05033.html

 Thomas
