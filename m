Received: from eggs.gnu.org ([2001:4830:134:3::10]:39721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA9dd-0000wT-2L
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gA9dY-0001Gt-56
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:14:37 -0400
References: <20181009175226.22138-1-akrowiak@linux.vnet.ibm.com>
	<20181009175226.22138-7-akrowiak@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ea0b09a9-dbbf-fc21-eabf-c0b943665f81@redhat.com>
Date: Wed, 10 Oct 2018 10:14:09 +0200
MIME-Version: 1.0
In-Reply-To: <20181009175226.22138-7-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v10 6/6] s390: doc: detailed
 specifications for AP virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 2018-10-09 19:52, Tony Krowiak wrote:
> This patch provides documentation describing the AP architecture and
> design concepts behind the virtualization of AP devices. It also
> includes an example of how to configure AP devices for exclusive
> use of KVM guests.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
> ---
>  MAINTAINERS      |   1 +
>  docs/vfio-ap.txt | 825 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 826 insertions(+)
>  create mode 100644 docs/vfio-ap.txt
[...]
> +      * Individual bits in the mask can be switched on and off by specifying
> +        each bit number to be switched in a comma separated list. Each bit
> +        number string must be prepended with a ('+') or minus ('-') to indicate
> +        the corresponding bit is to be switched on ('+') or off ('-'). Some
> +        valid values are: 

Nit: My git complains about a superfluous white space after "are:"

[...]
> +assign_adapter
> +   To assign an AP adapter to the mediated matrix device, its APID is written
> +   to the 'assign_adapter' file. This may be done multiple times to assign more
> +   than one adapter. The APID may be specified using conventional semantics
> +   as a decimal, hexidecimal, or octal number. For example, to assign adapters
> +   4, 5 and 16 to a mediated matrix device in decimal, hexidecimal and octal
> +   respectively:

In case you respin: I'd still prefer s/hexidecimal/hexadecimal/g in the
whole document (but it's just a nit, so no need to respin just because
of this)

 Thomas
