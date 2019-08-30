Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE9C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453872173E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 08:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453872173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3bw1-0003ZE-7n
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 04:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1i3bsy-0002MQ-K9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1i3bso-00038o-Gg
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 04:03:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mrezanin@redhat.com>)
 id 1i3bsX-0002Mb-7b; Fri, 30 Aug 2019 04:03:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66ABA10C030D;
 Fri, 30 Aug 2019 08:03:26 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 589505C207;
 Fri, 30 Aug 2019 08:03:26 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id F22424A460;
 Fri, 30 Aug 2019 08:03:25 +0000 (UTC)
Date: Fri, 30 Aug 2019 04:03:25 -0400 (EDT)
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <1226195980.9262063.1567152205754.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190828093447.12441-1-thuth@redhat.com>
References: <20190828093447.12441-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.103, 10.4.195.1]
Thread-Topic: qemu-doc: Do not hard-code the name of the QEMU binary
Thread-Index: +N2Uul8K57/o6bM/9N9rdACtS1n9VA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 30 Aug 2019 08:03:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Do not hard-code the name of the
 QEMU binary
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Thomas Huth" <thuth@redhat.com>
> To: qemu-devel@nongnu.org, "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: mrezanin@redhat.com, qemu-trivial@nongnu.org, "Richard Henderson" <rth@twiddle.net>, "Eduardo Habkost"
> <ehabkost@redhat.com>, qemu-block@nongnu.org
> Sent: Wednesday, August 28, 2019 11:34:47 AM
> Subject: [PATCH] qemu-doc: Do not hard-code the name of the QEMU binary
> 
> In our documentation, we use a mix of "$QEMU", "qemu-system-i386" and
> "qemu-system-x86_64" when we give examples to the users how to run
> QEMU. Some more consistency would be good here. Also some distributions
> use different names for the QEMU binary (e.g. "qemu-kvm" in RHEL), so
> providing more flexibility here would also be good. Thus let's define
> some variables for the names of the QEMU command and use those in the
> documentation instead: @value{qemu_system} for generic examples, and
> @value{qemu_system_x86} for examples that only work with the x86
> binaries.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/qemu-block-drivers.texi |  72 ++++++++++----------
>  docs/qemu-cpu-models.texi    |  10 +--
>  qemu-doc.texi                |  81 +++++++++++-----------
>  qemu-options.hx              | 128 +++++++++++++++++------------------
>  4 files changed, 149 insertions(+), 142 deletions(-)
> 
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> index c02547e28c..2c7ea49c32 100644
> --- a/docs/qemu-block-drivers.texi
> +++ b/docs/qemu-block-drivers.texi
> @@ -2,6 +2,8 @@
>  QEMU block driver reference manual
>  @c man end
>  
> +@set qemu_system qemu-system-x86_64
> +
>  @c man begin DESCRIPTION
>  
>  @node disk_images_formats
> @@ -405,7 +407,7 @@ QEMU can automatically create a virtual FAT disk image
> from a
>  directory tree. In order to use it, just type:
>  
>  @example
> -qemu-system-i386 linux.img -hdb fat:/my_directory
> +@value{qemu_system} linux.img -hdb fat:/my_directory
>  @end example
>  
>  Then you access access to all the files in the @file{/my_directory}
> @@ -415,14 +417,14 @@ them via SAMBA or NFS. The default access is
> @emph{read-only}.
>  Floppies can be emulated with the @code{:floppy:} option:
>  
>  @example
> -qemu-system-i386 linux.img -fda fat:floppy:/my_directory
> +@value{qemu_system} linux.img -fda fat:floppy:/my_directory
>  @end example
>  
>  A read/write support is available for testing (beta stage) with the
>  @code{:rw:} option:
>  
>  @example
> -qemu-system-i386 linux.img -fda fat:floppy:rw:/my_directory
> +@value{qemu_system} linux.img -fda fat:floppy:rw:/my_directory
>  @end example
>  
>  What you should @emph{never} do:
> @@ -440,14 +442,14 @@ QEMU can access directly to block device exported using
> the Network Block Device
>  protocol.
>  
>  @example
> -qemu-system-i386 linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
> +@value{qemu_system} linux.img -hdb nbd://my_nbd_server.mydomain.org:1024/
>  @end example
>  
>  If the NBD server is located on the same host, you can use an unix socket
>  instead
>  of an inet socket:
>  
>  @example
> -qemu-system-i386 linux.img -hdb nbd+unix://?socket=/tmp/my_socket
> +@value{qemu_system} linux.img -hdb nbd+unix://?socket=/tmp/my_socket
>  @end example
>  
>  In this case, the block device must be exported using qemu-nbd:
> @@ -464,23 +466,23 @@ qemu-nbd --socket=/tmp/my_socket --share=2
> my_disk.qcow2
>  @noindent
>  and then you can use it with two guests:
>  @example
> -qemu-system-i386 linux1.img -hdb nbd+unix://?socket=/tmp/my_socket
> -qemu-system-i386 linux2.img -hdb nbd+unix://?socket=/tmp/my_socket
> +@value{qemu_system} linux1.img -hdb nbd+unix://?socket=/tmp/my_socket
> +@value{qemu_system} linux2.img -hdb nbd+unix://?socket=/tmp/my_socket
>  @end example
>  
>  If the nbd-server uses named exports (supported since NBD 2.9.18, or with
>  QEMU's
>  own embedded NBD server), you must specify an export name in the URI:
>  @example
> -qemu-system-i386 -cdrom nbd://localhost/debian-500-ppc-netinst
> -qemu-system-i386 -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
> +@value{qemu_system} -cdrom nbd://localhost/debian-500-ppc-netinst
> +@value{qemu_system} -cdrom nbd://localhost/openSUSE-11.1-ppc-netinst
>  @end example
>  
>  The URI syntax for NBD is supported since QEMU 1.3.  An alternative syntax
>  is
>  also available.  Here are some example of the older syntax:
>  @example
> -qemu-system-i386 linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
> -qemu-system-i386 linux2.img -hdb nbd:unix:/tmp/my_socket
> -qemu-system-i386 -cdrom
> nbd:localhost:10809:exportname=debian-500-ppc-netinst
> +@value{qemu_system} linux.img -hdb nbd:my_nbd_server.mydomain.org:1024
> +@value{qemu_system} linux2.img -hdb nbd:unix:/tmp/my_socket
> +@value{qemu_system} -cdrom
> nbd:localhost:10809:exportname=debian-500-ppc-netinst
>  @end example
>  
>  @node disk_images_sheepdog
> @@ -505,7 +507,7 @@ qemu-img convert @var{filename} sheepdog:///@var{image}
>  
>  You can boot from the Sheepdog disk image with the command:
>  @example
> -qemu-system-i386 sheepdog:///@var{image}
> +@value{qemu_system} sheepdog:///@var{image}
>  @end example
>  
>  You can also create a snapshot of the Sheepdog image like qcow2.
> @@ -517,7 +519,7 @@ where @var{tag} is a tag name of the newly created
> snapshot.
>  To boot from the Sheepdog snapshot, specify the tag name of the
>  snapshot.
>  @example
> -qemu-system-i386 sheepdog:///@var{image}#@var{tag}
> +@value{qemu_system} sheepdog:///@var{image}#@var{tag}
>  @end example
>  
>  You can create a cloned image from the existing snapshot.
> @@ -530,14 +532,14 @@ is its tag name.
>  You can use an unix socket instead of an inet socket:
>  
>  @example
> -qemu-system-i386 sheepdog+unix:///@var{image}?socket=@var{path}
> +@value{qemu_system} sheepdog+unix:///@var{image}?socket=@var{path}
>  @end example
>  
>  If the Sheepdog daemon doesn't run on the local host, you need to
>  specify one of the Sheepdog servers to connect to.
>  @example
>  qemu-img create sheepdog://@var{hostname}:@var{port}/@var{image} @var{size}
> -qemu-system-i386 sheepdog://@var{hostname}:@var{port}/@var{image}
> +@value{qemu_system} sheepdog://@var{hostname}:@var{port}/@var{image}
>  @end example
>  
>  @node disk_images_iscsi
> @@ -627,7 +629,7 @@ cat >iscsi.conf <<EOF
>    header-digest = "CRC32C"
>  EOF
>  
> -qemu-system-i386 -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \
> +@value{qemu_system} -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \
>      -readconfig iscsi.conf
>  @end example
>  
> @@ -646,7 +648,7 @@ tgtadm --lld iscsi --mode logicalunit --op new --tid 1
> --lun 2 \
>      -b /IMAGES/cd.iso --device-type=cd
>  tgtadm --lld iscsi --op bind --mode target --tid 1 -I ALL
>  
> -qemu-system-i386 -iscsi initiator-name=iqn.qemu.test:my-initiator \
> +@value{qemu_system} -iscsi initiator-name=iqn.qemu.test:my-initiator \
>      -boot d -drive file=iscsi://127.0.0.1/iqn.qemu.test/1 \
>      -cdrom iscsi://127.0.0.1/iqn.qemu.test/2
>  @end example
> @@ -659,11 +661,11 @@ GlusterFS is a user space distributed file system.
>  You can boot from the GlusterFS disk image with the command:
>  @example
>  URI:
> -qemu-system-x86_64 -drive
> file=gluster[+@var{type}]://[@var{host}[:@var{port}]]/@var{volume}/@var{path}
> +@value{qemu_system} -drive
> file=gluster[+@var{type}]://[@var{host}[:@var{port}]]/@var{volume}/@var{path}
>                                 [?socket=...][,file.debug=9][,file.logfile=...]
>  
>  JSON:
> -qemu-system-x86_64 'json:@{"driver":"qcow2",
> +@value{qemu_system} 'json:@{"driver":"qcow2",
>                             "file":@{"driver":"gluster",
>                                      "volume":"testvol","path":"a.img","debug":9,"logfile":"...",
>                                      "server":[@{"type":"tcp","host":"...","port":"..."@},
> @@ -711,22 +713,22 @@ qemu-img create
> gluster://@var{host}/@var{volume}/@var{path} @var{size}
>  
>  Examples
>  @example
> -qemu-system-x86_64 -drive file=gluster://1.2.3.4/testvol/a.img
> -qemu-system-x86_64 -drive file=gluster+tcp://1.2.3.4/testvol/a.img
> -qemu-system-x86_64 -drive file=gluster+tcp://1.2.3.4:24007/testvol/dir/a.img
> -qemu-system-x86_64 -drive
> file=gluster+tcp://[1:2:3:4:5:6:7:8]/testvol/dir/a.img
> -qemu-system-x86_64 -drive
> file=gluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir/a.img
> -qemu-system-x86_64 -drive
> file=gluster+tcp://server.domain.com:24007/testvol/dir/a.img
> -qemu-system-x86_64 -drive
> file=gluster+unix:///testvol/dir/a.img?socket=/tmp/glusterd.socket
> -qemu-system-x86_64 -drive file=gluster+rdma://1.2.3.4:24007/testvol/a.img
> -qemu-system-x86_64 -drive
> file=gluster://1.2.3.4/testvol/a.img,file.debug=9,file.logfile=/var/log/qemu-gluster.log
> -qemu-system-x86_64 'json:@{"driver":"qcow2",
> +@value{qemu_system} -drive file=gluster://1.2.3.4/testvol/a.img
> +@value{qemu_system} -drive file=gluster+tcp://1.2.3.4/testvol/a.img
> +@value{qemu_system} -drive
> file=gluster+tcp://1.2.3.4:24007/testvol/dir/a.img
> +@value{qemu_system} -drive
> file=gluster+tcp://[1:2:3:4:5:6:7:8]/testvol/dir/a.img
> +@value{qemu_system} -drive
> file=gluster+tcp://[1:2:3:4:5:6:7:8]:24007/testvol/dir/a.img
> +@value{qemu_system} -drive
> file=gluster+tcp://server.domain.com:24007/testvol/dir/a.img
> +@value{qemu_system} -drive
> file=gluster+unix:///testvol/dir/a.img?socket=/tmp/glusterd.socket
> +@value{qemu_system} -drive file=gluster+rdma://1.2.3.4:24007/testvol/a.img
> +@value{qemu_system} -drive
> file=gluster://1.2.3.4/testvol/a.img,file.debug=9,file.logfile=/var/log/qemu-gluster.log
> +@value{qemu_system} 'json:@{"driver":"qcow2",
>                             "file":@{"driver":"gluster",
>                                      "volume":"testvol","path":"a.img",
>                                      "debug":9,"logfile":"/var/log/qemu-gluster.log",
>                                      "server":[@{"type":"tcp","host":"1.2.3.4","port":24007@},
>                                                @{"type":"unix","socket":"/var/run/glusterd.socket"@}]@}@}'
> -qemu-system-x86_64 -drive
> driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
> +@value{qemu_system} -drive
> driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
>                                         file.debug=9,file.logfile=/var/log/qemu-gluster.log,
>                                         file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
>                                         file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
> @@ -739,13 +741,13 @@ You can access disk images located on a remote ssh
> server
>  by using the ssh protocol:
>  
>  @example
> -qemu-system-x86_64 -drive
> file=ssh://[@var{user}@@]@var{server}[:@var{port}]/@var{path}[?host_key_check=@var{host_key_check}]
> +@value{qemu_system} -drive
> file=ssh://[@var{user}@@]@var{server}[:@var{port}]/@var{path}[?host_key_check=@var{host_key_check}]
>  @end example
>  
>  Alternative syntax using properties:
>  
>  @example
> -qemu-system-x86_64 -drive
> file.driver=ssh[,file.user=@var{user}],file.host=@var{server}[,file.port=@var{port}],file.path=@var{path}[,file.host_key_check=@var{host_key_check}]
> +@value{qemu_system} -drive
> file.driver=ssh[,file.user=@var{user}],file.host=@var{server}[,file.port=@var{port}],file.path=@var{path}[,file.host_key_check=@var{host_key_check}]
>  @end example
>  
>  @var{ssh} is the protocol.
> @@ -808,13 +810,13 @@ driver.  For example:
>  # echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
>  # echo 1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
>  
> -# qemu-system-x86_64 -drive
> file=nvme://@var{host}:@var{bus}:@var{slot}.@var{func}/@var{namespace}
> +# @value{qemu_system} -drive
> file=nvme://@var{host}:@var{bus}:@var{slot}.@var{func}/@var{namespace}
>  @end example
>  
>  Alternative syntax using properties:
>  
>  @example
> -qemu-system-x86_64 -drive
> file.driver=nvme,file.device=@var{host}:@var{bus}:@var{slot}.@var{func},file.namespace=@var{namespace}
> +@value{qemu_system} -drive
> file.driver=nvme,file.device=@var{host}:@var{bus}:@var{slot}.@var{func},file.namespace=@var{namespace}
>  @end example
>  
>  @var{host}:@var{bus}:@var{slot}.@var{func} is the NVMe controller's PCI
>  device
> diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
> index ad040cfc98..f88a1def0d 100644
> --- a/docs/qemu-cpu-models.texi
> +++ b/docs/qemu-cpu-models.texi
> @@ -2,6 +2,8 @@
>  QEMU / KVM CPU model configuration
>  @c man end
>  
> +@set qemu_system_x86 qemu-system-x86_64
> +
>  @c man begin DESCRIPTION
>  
>  @menu
> @@ -578,25 +580,25 @@ CPU models / features in QEMU and libvirt
>  @item Host passthrough
>  
>  @example
> -   $ qemu-system-x86_64 -cpu host
> +   $ @value{qemu_system_x86} -cpu host
>  @end example
>  
>  With feature customization:
>  
>  @example
> -   $ qemu-system-x86_64 -cpu host,-vmx,...
> +   $ @value{qemu_system_x86} -cpu host,-vmx,...
>  @end example
>  
>  @item Named CPU models
>  
>  @example
> -   $ qemu-system-x86_64 -cpu Westmere
> +   $ @value{qemu_system_x86} -cpu Westmere
>  @end example
>  
>  With feature customization:
>  
>  @example
> -   $ qemu-system-x86_64 -cpu Westmere,+pcid,...
> +   $ @value{qemu_system_x86} -cpu Westmere,+pcid,...
>  @end example
>  
>  @end table
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 577d1e8376..b2654c76a0 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -11,6 +11,9 @@
>  @paragraphindent 0
>  @c %**end of header
>  
> +@set qemu_system qemu-system-x86_64
> +@set qemu_system_x86 qemu-system-x86_64
> +
>  @ifinfo
>  @direntry
>  * QEMU: (qemu-doc).    The QEMU Emulator User Documentation.
> @@ -207,12 +210,12 @@ Note that, by default, GUS shares IRQ(7) with parallel
> ports and so
>  QEMU must be told to not have parallel ports to have working GUS.
>  
>  @example
> -qemu-system-i386 dos.img -soundhw gus -parallel none
> +@value{qemu_system_x86} dos.img -soundhw gus -parallel none
>  @end example
>  
>  Alternatively:
>  @example
> -qemu-system-i386 dos.img -device gus,irq=5
> +@value{qemu_system_x86} dos.img -device gus,irq=5
>  @end example
>  
>  Or some other unclaimed IRQ.
> @@ -225,10 +228,11 @@ CS4231A is the chip used in Windows Sound System and
> GUSMAX products
>  @section Quick Start
>  @cindex quick start
>  
> -Download and uncompress the linux image (@file{linux.img}) and type:
> +Download and uncompress a hard disk image with Linux installed (e.g.
> +@file{linux.img}) and type:
>  
>  @example
> -qemu-system-i386 linux.img
> +@value{qemu_system} linux.img
>  @end example
>  
>  Linux should boot and give you a prompt.
> @@ -238,7 +242,7 @@ Linux should boot and give you a prompt.
>  
>  @example
>  @c man begin SYNOPSIS
> -@command{qemu-system-i386} [@var{options}] [@var{disk_image}]
> +@command{@value{qemu_system}} [@var{options}] [@var{disk_image}]
>  @c man end
>  @end example
>  
> @@ -278,21 +282,21 @@ is specified in seconds. The default is 0 which means
> no timeout. Libiscsi
>  
>  Example (without authentication):
>  @example
> -qemu-system-i386 -iscsi initiator-name=iqn.2001-04.com.example:my-initiator
> \
> +@value{qemu_system} -iscsi
> initiator-name=iqn.2001-04.com.example:my-initiator \
>                   -cdrom iscsi://192.0.2.1/iqn.2001-04.com.example/2 \
>                   -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
>  @end example
>  
>  Example (CHAP username/password via URL):
>  @example
> -qemu-system-i386 -drive
> file=iscsi://user%password@@192.0.2.1/iqn.2001-04.com.example/1
> +@value{qemu_system} -drive
> file=iscsi://user%password@@192.0.2.1/iqn.2001-04.com.example/1
>  @end example
>  
>  Example (CHAP username/password via environment variables):
>  @example
>  LIBISCSI_CHAP_USERNAME="user" \
>  LIBISCSI_CHAP_PASSWORD="password" \
> -qemu-system-i386 -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
> +@value{qemu_system} -drive file=iscsi://192.0.2.1/iqn.2001-04.com.example/1
>  @end example
>  
>  @item NBD
> @@ -307,12 +311,12 @@ Syntax for specifying a NBD device using Unix Domain
> Sockets
>  
>  Example for TCP
>  @example
> -qemu-system-i386 --drive file=nbd:192.0.2.1:30000
> +@value{qemu_system} --drive file=nbd:192.0.2.1:30000
>  @end example
>  
>  Example for Unix Domain Sockets
>  @example
> -qemu-system-i386 --drive file=nbd:unix:/tmp/nbd-socket
> +@value{qemu_system} --drive file=nbd:unix:/tmp/nbd-socket
>  @end example
>  
>  @item SSH
> @@ -320,8 +324,8 @@ QEMU supports SSH (Secure Shell) access to remote disks.
>  
>  Examples:
>  @example
> -qemu-system-i386 -drive file=ssh://user@@host/path/to/disk.img
> -qemu-system-i386 -drive
> file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
> +@value{qemu_system} -drive file=ssh://user@@host/path/to/disk.img
> +@value{qemu_system} -drive
> file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
>  @end example
>  
>  Currently authentication must be done using ssh-agent.  Other
> @@ -339,7 +343,7 @@
> sheepdog[+tcp|+unix]://[host:port]/vdiname[?socket=path][#snapid|#tag]
>  
>  Example
>  @example
> -qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
> +@value{qemu_system} --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
>  @end example
>  
>  See also @url{https://sheepdog.github.io/sheepdog/}.
> @@ -365,17 +369,17 @@ JSON:
>  Example
>  @example
>  URI:
> -qemu-system-x86_64 --drive file=gluster://192.0.2.1/testvol/a.img,
> +@value{qemu_system} --drive file=gluster://192.0.2.1/testvol/a.img,
>  @
>  file.debug=9,file.logfile=/var/log/qemu-gluster.log
>  
>  JSON:
> -qemu-system-x86_64 'json:@{"driver":"qcow2",
> +@value{qemu_system} 'json:@{"driver":"qcow2",
>  @                          "file":@{"driver":"gluster",
>  @                                   "volume":"testvol","path":"a.img",
>  @
>  "debug":9,"logfile":"/var/log/qemu-gluster.log",
>  @
>  "server":[@{"type":"tcp","host":"1.2.3.4","port":24007@},
>  @
>  @{"type":"unix","socket":"/var/run/glusterd.socket"@}]@}@}'
> -qemu-system-x86_64 -drive
> driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
> +@value{qemu_system} -drive
> driver=qcow2,file.driver=gluster,file.volume=testvol,file.path=/path/a.img,
>  @
>  file.debug=9,file.logfile=/var/log/qemu-gluster.log,
>  @
>  file.server.0.type=tcp,file.server.0.host=1.2.3.4,file.server.0.port=24007,
>  @
>  file.server.1.type=unix,file.server.1.socket=/var/run/glusterd.socket
> @@ -440,9 +444,9 @@ of <protocol>.
>  
>  Example: boot from a remote Fedora 20 live ISO image
>  @example
> -qemu-system-x86_64 --drive
> media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
> +@value{qemu_system_x86} --drive
> media=cdrom,file=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
>  
> -qemu-system-x86_64 --drive
> media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
> +@value{qemu_system_x86} --drive
> media=cdrom,file.driver=http,file.url=http://dl.fedoraproject.org/pub/fedora/linux/releases/20/Live/x86_64/Fedora-Live-Desktop-x86_64-20-1.iso,readonly
>  @end example
>  
>  Example: boot from a remote Fedora 20 cloud image using a local overlay for
> @@ -450,7 +454,7 @@ writes, copy-on-read, and a readahead of 64k
>  @example
>  qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"http",,
>  "file.url":"https://dl.fedoraproject.org/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2",,
>  "file.readahead":"64k"@}' /tmp/Fedora-x86_64-20-20131211.1-sda.qcow2
>  
> -qemu-system-x86_64 -drive
> file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
> +@value{qemu_system_x86} -drive
> file=/tmp/Fedora-x86_64-20-20131211.1-sda.qcow2,copy-on-read=on
>  @end example
>  
>  Example: boot from an image stored on a VMware vSphere server with a
>  self-signed
> @@ -459,7 +463,7 @@ of 10 seconds.
>  @example
>  qemu-img create -f qcow2 -o backing_file='json:@{"file.driver":"https",,
>  "file.url":"https://user:password@@vsphere.example.com/folder/test/test-flat.vmdk?dcPath=Datacenter&dsName=datastore1",,
>  "file.sslverify":"off",, "file.readahead":"64k",, "file.timeout":10@}'
>  /tmp/test.qcow2
>  
> -qemu-system-x86_64 -drive file=/tmp/test.qcow2
> +@value{qemu_system_x86} -drive file=/tmp/test.qcow2
>  @end example
>  
>  @end table
> @@ -826,7 +830,7 @@ On Linux hosts, a shared memory device is available.  The
> basic syntax
>  is:
>  
>  @example
> -qemu-system-x86_64 -device ivshmem-plain,memdev=@var{hostmem}
> +@value{qemu_system_x86} -device ivshmem-plain,memdev=@var{hostmem}
>  @end example
>  
>  where @var{hostmem} names a host memory backend.  For a POSIX shared
> @@ -847,7 +851,7 @@ memory server is:
>  ivshmem-server -p @var{pidfile} -S @var{path} -m @var{shm-name} -l
>  @var{shm-size} -n @var{vectors}
>  
>  # Then start your qemu instances with matching arguments
> -qemu-system-x86_64 -device
> ivshmem-doorbell,vectors=@var{vectors},chardev=@var{id}
> +@value{qemu_system_x86} -device
> ivshmem-doorbell,vectors=@var{vectors},chardev=@var{id}
>                   -chardev socket,path=@var{path},id=@var{id}
>  @end example
>  
> @@ -872,7 +876,7 @@ Instead of specifying the <shm size> using POSIX shm, you
> may specify
>  a memory backend that has hugepage support:
>  
>  @example
> -qemu-system-x86_64 -object
> memory-backend-file,size=1G,mem-path=/dev/hugepages/my-shmem-file,share,id=mb1
> +@value{qemu_system_x86} -object
> memory-backend-file,size=1G,mem-path=/dev/hugepages/my-shmem-file,share,id=mb1
>                   -device ivshmem-plain,memdev=mb1
>  @end example
>  
> @@ -888,7 +892,7 @@ kernel testing.
>  
>  The syntax is:
>  @example
> -qemu-system-i386 -kernel arch/i386/boot/bzImage -hda root-2.4.20.img -append
> "root=/dev/hda"
> +@value{qemu_system} -kernel bzImage -hda rootdisk.img -append
> "root=/dev/hda"
>  @end example
>  
>  Use @option{-kernel} to provide the Linux kernel image and
> @@ -903,7 +907,7 @@ If you do not need graphical output, you can disable it
> and redirect
>  the virtual serial port and the QEMU monitor to the console with the
>  @option{-nographic} option. The typical command line is:
>  @example
> -qemu-system-i386 -kernel arch/i386/boot/bzImage -hda root-2.4.20.img \
> +@value{qemu_system} -kernel bzImage -hda rootdisk.img \
>                   -append "root=/dev/hda console=ttyS0" -nographic
>  @end example
>  
> @@ -969,7 +973,7 @@ Network adapter that supports CDC ethernet and RNDIS
> protocols.  @var{id}
>  specifies a netdev defined with @code{-netdev @dots{},id=@var{id}}.
>  For instance, user-mode networking can be used with
>  @example
> -qemu-system-i386 [...] -netdev user,id=net0 -device usb-net,netdev=net0
> +@value{qemu_system} [...] -netdev user,id=net0 -device usb-net,netdev=net0
>  @end example
>  @item usb-ccid
>  Smartcard reader device
> @@ -988,7 +992,7 @@ no type is given, the HCI logic corresponds to @code{-bt
> hci,vlan=0}.
>  This USB device implements the USB Transport Layer of HCI.  Example
>  usage:
>  @example
> -@command{qemu-system-i386} [...@var{OPTIONS}...] @option{-usbdevice}
> bt:hci,vlan=3 @option{-bt} device:keyboard,vlan=3
> +@command{@value{qemu_system}} [...@var{OPTIONS}...] @option{-usbdevice}
> bt:hci,vlan=3 @option{-bt} device:keyboard,vlan=3
>  @end example
>  @end table
>  
> @@ -1065,7 +1069,7 @@ For this setup it is recommended to restrict it to
> listen on a UNIX domain
>  socket only. For example
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] -vnc unix:/home/joebloggs/.qemu-myvm-vnc
> +@value{qemu_system} [...OPTIONS...] -vnc unix:/home/joebloggs/.qemu-myvm-vnc
>  @end example
>  
>  This ensures that only users on local box with read/write access to that
> @@ -1088,7 +1092,7 @@ is running the password is set with the monitor. Until
> the monitor is used to
>  set the password all clients will be rejected.
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] -vnc :1,password -monitor stdio
> +@value{qemu_system} [...OPTIONS...] -vnc :1,password -monitor stdio
>  (qemu) change vnc password
>  Password: ********
>  (qemu)
> @@ -1105,7 +1109,7 @@ support provides a secure session, but no
> authentication. This allows any
>  client to connect, and provides an encrypted session.
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] \
> +@value{qemu_system} [...OPTIONS...] \
>    -object
>    tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=no \
>    -vnc :1,tls-creds=tls0 -monitor stdio
>  @end example
> @@ -1127,7 +1131,7 @@ same syntax as previously, but with @code{verify-peer}
> set to @code{yes}
>  instead.
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] \
> +@value{qemu_system} [...OPTIONS...] \
>    -object
>    tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes
>    \
>    -vnc :1,tls-creds=tls0 -monitor stdio
>  @end example
> @@ -1140,7 +1144,7 @@ Finally, the previous method can be combined with VNC
> password authentication
>  to provide two layers of authentication for clients.
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] \
> +@value{qemu_system} [...OPTIONS...] \
>    -object
>    tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes
>    \
>    -vnc :1,tls-creds=tls0,password -monitor stdio
>  (qemu) change vnc password
> @@ -1165,7 +1169,7 @@ used for authentication, but assuming use of one
> supporting SSF,
>  then QEMU can be launched with:
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] -vnc :1,sasl -monitor stdio
> +@value{qemu_system} [...OPTIONS...] -vnc :1,sasl -monitor stdio
>  @end example
>  
>  @node vnc_sec_certificate_sasl
> @@ -1179,7 +1183,7 @@ credentials. This can be enabled, by combining the
> 'sasl' option
>  with the aforementioned TLS + x509 options:
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] \
> +@value{qemu_system} [...OPTIONS...] \
>    -object
>    tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes
>    \
>    -vnc :1,tls-creds=tls0,sasl -monitor stdio
>  @end example
> @@ -1512,13 +1516,13 @@ To load server credentials with client certificate
> validation
>  enabled
>  
>  @example
> -$QEMU -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server
> +@value{qemu_system} -object
> tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server
>  @end example
>  
>  while to load client credentials use
>  
>  @example
> -$QEMU -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=client
> +@value{qemu_system} -object
> tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=client
>  @end example
>  
>  Network services which support TLS will all have a @code{tls-creds}
> @@ -1526,7 +1530,7 @@ parameter which expects the ID of the TLS credentials
> object. For
>  example with VNC:
>  
>  @example
> -$QEMU -vnc 0.0.0.0:0,tls-creds=tls0
> +@value{qemu_system} -vnc 0.0.0.0:0,tls-creds=tls0
>  @end example
>  
>  @node tls_psk
> @@ -1574,8 +1578,7 @@ QEMU has a primitive support to work with gdb, so that
> you can do
>  In order to use gdb, launch QEMU with the '-s' option. It will wait for a
>  gdb connection:
>  @example
> -qemu-system-i386 -s -kernel arch/i386/boot/bzImage -hda root-2.4.20.img \
> -                    -append "root=/dev/hda"
> +@value{qemu_system} -s -kernel bzImage -hda rootdisk.img -append
> "root=/dev/hda"
>  Connected to host network interface: tun0
>  Waiting gdb connection on port 1234
>  @end example
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ea0638e92d..09e6439646 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -254,10 +254,10 @@ This option defines a free-form string that can be used
> to describe @var{fd}.
>  
>  You can open an image using pre-opened file descriptors from an fd set:
>  @example
> -qemu-system-i386
> --add-fd fd=3,set=2,opaque="rdwr:/path/to/file"
> --add-fd fd=4,set=2,opaque="rdonly:/path/to/file"
> --drive file=/dev/fdset/2,index=0,media=disk
> +@value{qemu_system} \
> + -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \
> + -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \
> + -drive file=/dev/fdset/2,index=0,media=disk
>  @end example
>  ETEXI
>  
> @@ -283,7 +283,7 @@ STEXI
>  Set default value of @var{driver}'s property @var{prop} to @var{value},
>  e.g.:
>  
>  @example
> -qemu-system-i386 -global ide-hd.physical_block_size=4096 disk-image.img
> +@value{qemu_system_x86} -global ide-hd.physical_block_size=4096
> disk-image.img
>  @end example
>  
>  In particular, you can use this to set driver properties for devices which
>  are
> @@ -337,11 +337,11 @@ bootindex options. The default is non-strict boot.
>  
>  @example
>  # try to boot from network first, then from hard disk
> -qemu-system-i386 -boot order=nc
> +@value{qemu_system_x86} -boot order=nc
>  # boot from CD-ROM first, switch back to default order after reboot
> -qemu-system-i386 -boot once=d
> +@value{qemu_system_x86} -boot once=d
>  # boot with a splash picture for 5 seconds.
> -qemu-system-i386 -boot menu=on,splash=/root/boot.bmp,splash-time=5000
> +@value{qemu_system_x86} -boot menu=on,splash=/root/boot.bmp,splash-time=5000
>  @end example
>  
>  Note: The legacy format '-boot @var{drives}' is still supported but its
> @@ -370,7 +370,7 @@ For example, the following command-line sets the guest
> startup RAM size to
>  memory the guest can reach to 4GB:
>  
>  @example
> -qemu-system-x86_64 -m 1G,slots=3,maxmem=4G
> +@value{qemu_system} -m 1G,slots=3,maxmem=4G
>  @end example
>  
>  If @var{slots} and @var{maxmem} are not specified, memory hotplug won't
> @@ -666,15 +666,15 @@ STEXI
>  @item -soundhw @var{card1}[,@var{card2},...] or -soundhw all
>  @findex -soundhw
>  Enable audio and selected sound hardware. Use 'help' to print all
> -available sound hardware.
> +available sound hardware. For example:
>  
>  @example
> -qemu-system-i386 -soundhw sb16,adlib disk.img
> -qemu-system-i386 -soundhw es1370 disk.img
> -qemu-system-i386 -soundhw ac97 disk.img
> -qemu-system-i386 -soundhw hda disk.img
> -qemu-system-i386 -soundhw all disk.img
> -qemu-system-i386 -soundhw help
> +@value{qemu_system_x86} -soundhw sb16,adlib disk.img
> +@value{qemu_system_x86} -soundhw es1370 disk.img
> +@value{qemu_system_x86} -soundhw ac97 disk.img
> +@value{qemu_system_x86} -soundhw hda disk.img
> +@value{qemu_system_x86} -soundhw all disk.img
> +@value{qemu_system_x86} -soundhw help
>  @end example
>  
>  Note that Linux's i810_audio OSS kernel (for AC97) module might
> @@ -1149,50 +1149,50 @@ is off.
>  
>  Instead of @option{-cdrom} you can use:
>  @example
> -qemu-system-i386 -drive file=file,index=2,media=cdrom
> +@value{qemu_system} -drive file=file,index=2,media=cdrom
>  @end example
>  
>  Instead of @option{-hda}, @option{-hdb}, @option{-hdc}, @option{-hdd}, you
>  can
>  use:
>  @example
> -qemu-system-i386 -drive file=file,index=0,media=disk
> -qemu-system-i386 -drive file=file,index=1,media=disk
> -qemu-system-i386 -drive file=file,index=2,media=disk
> -qemu-system-i386 -drive file=file,index=3,media=disk
> +@value{qemu_system} -drive file=file,index=0,media=disk
> +@value{qemu_system} -drive file=file,index=1,media=disk
> +@value{qemu_system} -drive file=file,index=2,media=disk
> +@value{qemu_system} -drive file=file,index=3,media=disk
>  @end example
>  
>  You can open an image using pre-opened file descriptors from an fd set:
>  @example
> -qemu-system-i386
> --add-fd fd=3,set=2,opaque="rdwr:/path/to/file"
> --add-fd fd=4,set=2,opaque="rdonly:/path/to/file"
> --drive file=/dev/fdset/2,index=0,media=disk
> +@value{qemu_system} \
> + -add-fd fd=3,set=2,opaque="rdwr:/path/to/file" \
> + -add-fd fd=4,set=2,opaque="rdonly:/path/to/file" \
> + -drive file=/dev/fdset/2,index=0,media=disk
>  @end example
>  
>  You can connect a CDROM to the slave of ide0:
>  @example
> -qemu-system-i386 -drive file=file,if=ide,index=1,media=cdrom
> +@value{qemu_system_x86} -drive file=file,if=ide,index=1,media=cdrom
>  @end example
>  
>  If you don't specify the "file=" argument, you define an empty drive:
>  @example
> -qemu-system-i386 -drive if=ide,index=1,media=cdrom
> +@value{qemu_system_x86} -drive if=ide,index=1,media=cdrom
>  @end example
>  
>  Instead of @option{-fda}, @option{-fdb}, you can use:
>  @example
> -qemu-system-i386 -drive file=file,index=0,if=floppy
> -qemu-system-i386 -drive file=file,index=1,if=floppy
> +@value{qemu_system_x86} -drive file=file,index=0,if=floppy
> +@value{qemu_system_x86} -drive file=file,index=1,if=floppy
>  @end example
>  
>  By default, @var{interface} is "ide" and @var{index} is automatically
>  incremented:
>  @example
> -qemu-system-i386 -drive file=a -drive file=b"
> +@value{qemu_system_x86} -drive file=a -drive file=b"
>  @end example
>  is interpreted like:
>  @example
> -qemu-system-i386 -hda a -hdb b
> +@value{qemu_system_x86} -hda a -hdb b
>  @end example
>  ETEXI
>  
> @@ -2272,8 +2272,8 @@ The following two example do exactly the same, to show
> how @option{-nic} can
>  be used to shorten the command line length (note that the e1000 is the
>  default
>  on i386, so the @option{model=e1000} parameter could even be omitted here,
>  too):
>  @example
> -qemu-system-i386 -netdev user,id=n1,ipv6=off -device
> e1000,netdev=n1,mac=52:54:98:76:54:32
> -qemu-system-i386 -nic user,ipv6=off,model=e1000,mac=52:54:98:76:54:32
> +@value{qemu_system} -netdev user,id=n1,ipv6=off -device
> e1000,netdev=n1,mac=52:54:98:76:54:32
> +@value{qemu_system} -nic user,ipv6=off,model=e1000,mac=52:54:98:76:54:32
>  @end example
>  
>  @item -nic none
> @@ -2344,7 +2344,7 @@ can not be resolved.
>  
>  Example:
>  @example
> -qemu-system-i386 -nic user,dnssearch=mgmt.example.org,dnssearch=example.org
> +@value{qemu_system} -nic
> user,dnssearch=mgmt.example.org,dnssearch=example.org
>  @end example
>  
>  @item domainname=@var{domain}
> @@ -2368,7 +2368,7 @@ a guest from a local directory.
>  
>  Example (using pxelinux):
>  @example
> -qemu-system-i386 -hda linux.img -boot n -device e1000,netdev=n1 \
> +@value{qemu_system} -hda linux.img -boot n -device e1000,netdev=n1 \
>      -netdev user,id=n1,tftp=/path/to/tftp/files,bootfile=/pxelinux.0
>  @end example
>  
> @@ -2402,7 +2402,7 @@ screen 0, use the following:
>  
>  @example
>  # on the host
> -qemu-system-i386 -nic user,hostfwd=tcp:127.0.0.1:6001-:6000
> +@value{qemu_system} -nic user,hostfwd=tcp:127.0.0.1:6001-:6000
>  # this host xterm should open in the guest X11 server
>  xterm -display :1
>  @end example
> @@ -2412,7 +2412,7 @@ the guest, use the following:
>  
>  @example
>  # on the host
> -qemu-system-i386 -nic user,hostfwd=tcp::5555-:23
> +@value{qemu_system} -nic user,hostfwd=tcp::5555-:23
>  telnet localhost 5555
>  @end example
>  
> @@ -2431,7 +2431,7 @@ lifetime, like in the following example:
>  @example
>  # open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to it whenever
>  # the guest accesses it
> -qemu-system-i386 -nic user,guestfwd=tcp:10.0.2.100:1234-tcp:10.10.1.1:4321
> +@value{qemu_system} -nic
> user,guestfwd=tcp:10.0.2.100:1234-tcp:10.10.1.1:4321
>  @end example
>  
>  Or you can execute a command on every TCP connection established by the
>  guest,
> @@ -2440,7 +2440,7 @@ so that QEMU behaves similar to an inetd process for
> that virtual server:
>  @example
>  # call "netcat 10.10.1.1 4321" on every TCP connection to 10.0.2.100:1234
>  # and connect the TCP stream to its stdin/stdout
> -qemu-system-i386 -nic  'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat
> 10.10.1.1 4321'
> +@value{qemu_system} -nic
> 'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
>  @end example
>  
>  @end table
> @@ -2467,13 +2467,13 @@ Examples:
>  
>  @example
>  #launch a QEMU instance with the default network script
> -qemu-system-i386 linux.img -nic tap
> +@value{qemu_system} linux.img -nic tap
>  @end example
>  
>  @example
>  #launch a QEMU instance with two NICs, each one connected
>  #to a TAP device
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>          -netdev tap,id=nd0,ifname=tap0 -device e1000,netdev=nd0 \
>          -netdev tap,id=nd1,ifname=tap1 -device rtl8139,netdev=nd1
>  @end example
> @@ -2481,7 +2481,7 @@ qemu-system-i386 linux.img \
>  @example
>  #launch a QEMU instance with the default network helper to
>  #connect a TAP device to bridge br0
> -qemu-system-i386 linux.img -device virtio-net-pci,netdev=n1 \
> +@value{qemu_system} linux.img -device virtio-net-pci,netdev=n1 \
>          -netdev tap,id=n1,"helper=/path/to/qemu-bridge-helper"
>  @end example
>  
> @@ -2498,13 +2498,13 @@ Examples:
>  @example
>  #launch a QEMU instance with the default network helper to
>  #connect a TAP device to bridge br0
> -qemu-system-i386 linux.img -netdev bridge,id=n1 -device virtio-net,netdev=n1
> +@value{qemu_system} linux.img -netdev bridge,id=n1 -device
> virtio-net,netdev=n1
>  @end example
>  
>  @example
>  #launch a QEMU instance with the default network helper to
>  #connect a TAP device to bridge qemubr0
> -qemu-system-i386 linux.img -netdev bridge,br=qemubr0,id=n1 -device
> virtio-net,netdev=n1
> +@value{qemu_system} linux.img -netdev bridge,br=qemubr0,id=n1 -device
> virtio-net,netdev=n1
>  @end example
>  
>  @item -netdev
>  socket,id=@var{id}[,fd=@var{h}][,listen=[@var{host}]:@var{port}][,connect=@var{host}:@var{port}]
> @@ -2519,11 +2519,11 @@ specifies an already opened TCP socket.
>  Example:
>  @example
>  # launch a first QEMU instance
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>                   -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
>                   -netdev socket,id=n1,listen=:1234
>  # connect the network of this instance to the network of the first instance
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>                   -device e1000,netdev=n2,mac=52:54:00:12:34:57 \
>                   -netdev socket,id=n2,connect=127.0.0.1:1234
>  @end example
> @@ -2548,15 +2548,15 @@ Use @option{fd=h} to specify an already opened UDP
> multicast socket.
>  Example:
>  @example
>  # launch one QEMU instance
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>                   -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
>                   -netdev socket,id=n1,mcast=230.0.0.1:1234
>  # launch another QEMU instance on same "bus"
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>                   -device e1000,netdev=n2,mac=52:54:00:12:34:57 \
>                   -netdev socket,id=n2,mcast=230.0.0.1:1234
>  # launch yet another QEMU instance on same "bus"
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>                   -device e1000,netdev=n3,mac=52:54:00:12:34:58 \
>                   -netdev socket,id=n3,mcast=230.0.0.1:1234
>  @end example
> @@ -2564,7 +2564,7 @@ qemu-system-i386 linux.img \
>  Example (User Mode Linux compat.):
>  @example
>  # launch QEMU instance (note mcast address selected is UML's default)
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>                   -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
>                   -netdev socket,id=n1,mcast=239.192.168.1:1102
>  # launch UML
> @@ -2573,7 +2573,7 @@ qemu-system-i386 linux.img \
>  
>  Example (send packets from host's 1.2.3.4):
>  @example
> -qemu-system-i386 linux.img \
> +@value{qemu_system} linux.img \
>                   -device e1000,netdev=n1,mac=52:54:00:12:34:56 \
>                   -netdev
>                   socket,id=n1,mcast=239.192.168.1:1102,localaddr=1.2.3.4
>  @end example
> @@ -2633,7 +2633,7 @@ brctl addif br-lan vmtunnel0
>  # on 4.3.2.1
>  # launch QEMU instance - if your network has reorder or is very lossy add
>  ,pincounter
>  
> -qemu-system-i386 linux.img -device e1000,netdev=n1 \
> +@value{qemu_system} linux.img -device e1000,netdev=n1 \
>      -netdev
>      l2tpv3,id=n1,src=4.2.3.1,dst=1.2.3.4,udp,srcport=16384,dstport=16384,rxsession=0xffffffff,txsession=0xffffffff,counter
>  
>  @end example
> @@ -2650,7 +2650,7 @@ Example:
>  # launch vde switch
>  vde_switch -F -sock /tmp/myswitch
>  # launch QEMU instance
> -qemu-system-i386 linux.img -nic vde,sock=/tmp/myswitch
> +@value{qemu_system} linux.img -nic vde,sock=/tmp/myswitch
>  @end example
>  
>  @item -netdev vhost-user,chardev=@var{id}[,vhostforce=on|off][,queues=n]
> @@ -3107,7 +3107,7 @@ and communicate.  Requires the Linux @code{vhci} driver
> installed.  Can
>  be used as following:
>  
>  @example
> -qemu-system-i386 [...OPTIONS...] -bt hci,vlan=5 -bt vhci,vlan=5
> +@value{qemu_system} [...OPTIONS...] -bt hci,vlan=5 -bt vhci,vlan=5
>  @end example
>  
>  @item -bt device:@var{dev}[,vlan=@var{n}]
> @@ -3601,7 +3601,7 @@ connections will likely be TCP-based, but also UDP,
> pseudo TTY, or even
>  stdio are reasonable use case. The latter is allowing to start QEMU from
>  within gdb and establish the connection via a pipe:
>  @example
> -(gdb) target remote | exec qemu-system-i386 -gdb stdio ...
> +(gdb) target remote | exec @value{qemu_system} -gdb stdio ...
>  @end example
>  ETEXI
>  
> @@ -4571,7 +4571,7 @@ which specify the queue number of cryptodev backend,
> the default of
>  
>  @example
>  
> - # qemu-system-x86_64 \
> + # @value{qemu_system} \
>     [...] \
>         -object cryptodev-backend-builtin,id=cryptodev0 \
>         -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
> @@ -4591,7 +4591,7 @@ of cryptodev backend for multiqueue vhost-user, the
> default of @var{queues} is 1
>  
>  @example
>  
> - # qemu-system-x86_64 \
> + # @value{qemu_system} \
>     [...] \
>         -chardev socket,id=chardev0,path=/path/to/socket \
>         -object cryptodev-vhost-user,id=cryptodev0,chardev=chardev0 \
> @@ -4627,14 +4627,14 @@ The simplest (insecure) usage is to provide the
> secret inline
>  
>  @example
>  
> - # $QEMU -object secret,id=sec0,data=letmein,format=raw
> + # @value{qemu_system} -object secret,id=sec0,data=letmein,format=raw
>  
>  @end example
>  
>  The simplest secure usage is to provide the secret via a file
>  
>   # printf "letmein" > mypasswd.txt
> - # $QEMU -object secret,id=sec0,file=mypasswd.txt,format=raw
> + # @value{qemu_system} -object secret,id=sec0,file=mypasswd.txt,format=raw
>  
>  For greater security, AES-256-CBC should be used. To illustrate usage,
>  consider the openssl command line tool which can encrypt the data. Note
> @@ -4670,7 +4670,7 @@ and specify that to be used to decrypt the user
> password. Pass the
>  contents of @code{iv.b64} to the second secret
>  
>  @example
> - # $QEMU \
> + # @value{qemu_system} \
>       -object secret,id=secmaster0,format=base64,file=key.b64 \
>       -object secret,id=sec0,keyid=secmaster0,format=base64,\
>           data=$SECRET,iv=$(<iv.b64)
> @@ -4713,7 +4713,7 @@ negotiate keys used for attestation. The file must be
> encoded in base64.
>  
>  e.g to launch a SEV guest
>  @example
> - # $QEMU \
> + # @value{qemu_system_x86} \
>       ......
>       -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5 \
>       -machine ...,memory-encryption=sev0
> @@ -4735,7 +4735,7 @@ any commas in the distinguished name.
>  An example authorization object to validate a x509 distinguished name
>  would look like:
>  @example
> - # $QEMU \
> + # @value{qemu_system} \
>       ...
>       -object
>       'authz-simple,id=auth0,identity=CN=laptop.example.com,,O=Example
>       Org,,L=London,,ST=London,,C=GB' \
>       ...
> @@ -4784,7 +4784,7 @@ a TLS x509 distinguished name, or a SASL username.
>  An example authorization object to validate a SASL username
>  would look like:
>  @example
> - # $QEMU \
> + # @value{qemu_system} \
>       ...
>       -object
>       authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes
>       ...
> @@ -4802,7 +4802,7 @@ An example authorization object to validate a TLS x509
> distinguished
>  name would look like:
>  
>  @example
> - # $QEMU \
> + # @value{qemu_system} \
>       ...
>       -object authz-pam,id=auth0,service=qemu-vnc
>       ...
> --
> 2.18.1
> 
> 

Useful change.

Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com>

-- 
Miroslav Rezanina
Software Engineer - Virtualization Team Maintainer


