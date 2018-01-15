Received: from eggs.gnu.org ([2001:4830:134:3::10]:41002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb5iZ-0006Zd-P5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb5iW-0005Ic-Kw
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:26:31 -0500
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
	<20180115120543.1f825292@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d3eeebf8-c94c-09dc-3d3d-0933dcedb8af@redhat.com>
Date: Mon, 15 Jan 2018 15:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180115120543.1f825292@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/2] Clean up the ppc default
 configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 15.01.2018 12:05, Greg Kurz wrote:
> On Mon, 15 Jan 2018 10:30:53 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> ppc64-softmmu is a superset of ppc-softmmu which in turn is a superset
> 
> Hi Thomas,
> 
> Per curiosity. I understand that a 64-bit ppc CPU is expected to support
> 32-bit ppc code, but does QEMU really need to emulate setups that likely
> never existed in real life (like a PowerMac G5 or a pSeries with an
> internal floppy disk controller for example) ?

I think the CONFIG_FDC switch is there for the PReP machine, not for the
Macs.

 Thomas
