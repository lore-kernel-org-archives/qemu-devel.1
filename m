Received: from eggs.gnu.org ([2001:4830:134:3::10]:42538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dx7jy-0002be-Av
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dx7jt-0003fU-Kl
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:30:46 -0400
References: <20170926121750.9015-1-lvivier@redhat.com>
	<20170927075917.GQ12504@umbus>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5f1a9e31-5471-6fdd-b885-441591aa9704@redhat.com>
Date: Wed, 27 Sep 2017 10:30:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170927075917.GQ12504@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: select default vty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 27/09/2017 09:59, David Gibson wrote:
> On Tue, Sep 26, 2017 at 02:17:50PM +0200, Laurent Vivier wrote:
>> SLOF uses the "/chosen/linux,stdout-path" variable to
>> choose its console. This variable is provided by QEMU.
>> QEMU selects the spapr-vty using the "reg" property:
>> it takes the vty with the lowest reg number.
>> This patch allows the user to define "linux,stdout-path"
>> from the command line by adding a keyword 'default' to
>> the spapr-vty device.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> I'm a bit dubious about the worth of this.  With your SLOF fixes it
> should still be possible to redirect output correctly using -prom-env,
> yes?  Using a secondary vty is a pretty niche case, so I'm not
> convinced we need extra properties just to make it simpler.

I agree, but there is a difference between the SLOF fix and the QEMU change:
- with the QEMU fix, all logs go immediately to the selected console,
- with SLOF fix, logs start to go on the console with the lowest reg
value, and switch later to the selected console.

Moreover, Thomas has pointed out that the SLOF fix slows the characters
output (x 6).

Thanks,
Laurent
