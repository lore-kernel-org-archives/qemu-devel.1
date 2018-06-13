Received: from eggs.gnu.org ([2001:4830:134:3::10]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT5FO-0007vH-E6
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT5FK-0004rO-CU
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:51:34 -0400
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-5-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4e92685-d487-9b86-5f5a-831e1cadef71@redhat.com>
Date: Wed, 13 Jun 2018 14:51:21 +0200
MIME-Version: 1.0
In-Reply-To: <1528866321-23886-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, zhang.zhanghailiang@huawei.com, Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org

On 13/06/2018 07:05, Thomas Huth wrote:
> We've got three ways of enabling an accelerator: -machine accel=xyz,
> -accel xyz and -enable-xyz. For new QEMU users, this must be very
> confusing ("Which one do I have to use? Is there a difference between
> the options?"). While -enable-kvm was useful in the past, there is no
> real good reason for using it anymore today ("-accel kvm" is even less
> to type than "-enable-kvm"), so let's decrease the confusing amount of
> options in our documenation a little bit by removing the -enable-xyz
> here. Note that the option itself is neither removed nor marked as
> deprecated - since -enable-kvm is likely used in a lot of scripts and
> since its code is easy to maintain, we should keep it around to avoid
> to break old setups.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  PS: I guess Paolo won't like this patch ... let's try it anyway ;-)

Heh.  I'm not sure actually.  I'm more in favor of introducing an
"Obsolete options" section and putting it there.

Paolo


>  qemu-options.hx | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0ec9cac..f33a81e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3414,25 +3414,11 @@ STEXI
>  Set the filename for the BIOS.
>  ETEXI
>  
> -DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
> -    "-enable-kvm     enable KVM full virtualization support\n", QEMU_ARCH_ALL)
> -STEXI
> -@item -enable-kvm
> -@findex -enable-kvm
> -Enable KVM full virtualization support. This option is only available
> -if KVM support is enabled when compiling.
> -ETEXI
> +HXCOMM -accel kvm should be used instead, thus this is not documented anymore
> +DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, "", QEMU_ARCH_ALL)
>  
> -DEF("enable-hax", 0, QEMU_OPTION_enable_hax, \
> -    "-enable-hax     enable HAX virtualization support\n", QEMU_ARCH_I386)
> -STEXI
> -@item -enable-hax
> -@findex -enable-hax
> -Enable HAX (Hardware-based Acceleration eXecution) support. This option
> -is only available if HAX support is enabled when compiling. HAX is only
> -applicable to MAC and Windows platform, and thus does not conflict with
> -KVM.
> -ETEXI
> +HXCOMM -accel hax should be used instead, thus this is not documented anymore
> +DEF("enable-hax", 0, QEMU_OPTION_enable_hax, "", QEMU_ARCH_I386)
>  
>  DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
>      "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
> 
