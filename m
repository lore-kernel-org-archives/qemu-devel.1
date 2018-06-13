Received: from eggs.gnu.org ([2001:4830:134:3::10]:49158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT5Fq-0008DT-Ey
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT5Fm-0005lT-FC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:52:02 -0400
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-3-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6ba65c5-3a44-86ca-27fd-bb4ccadd4d5f@redhat.com>
Date: Wed, 13 Jun 2018 14:51:38 +0200
MIME-Version: 1.0
In-Reply-To: <1528866321-23886-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] Replace '-enable-kvm' with '-accel
 kvm' in docs and help texts
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
> The preferred way to select the KVM accelerator is to use "-accel kvm"
> these days, so let's be consistent in our documentation and help texts.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/COLO-FT.txt                  | 8 ++++----
>  docs/can.txt                      | 4 ++--
>  docs/multi-thread-compression.txt | 2 +-
>  docs/multiseat.txt                | 2 +-
>  docs/specs/tpm.txt                | 8 ++++----
>  hw/block/dataplane/virtio-blk.c   | 4 ++--
>  hw/scsi/virtio-scsi-dataplane.c   | 4 ++--
>  7 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
> index e289be2..d7c7dcd 100644
> --- a/docs/COLO-FT.txt
> +++ b/docs/COLO-FT.txt
> @@ -113,16 +113,16 @@ by using 'x-colo-lost-heartbeat' command.
>  == Test procedure ==
>  1. Startup qemu
>  Primary:
> -# qemu-kvm -enable-kvm -m 2048 -smp 2 -qmp stdio -vnc :7 -name primary \
> -  -device piix3-usb-uhci \
> +# qemu-system-x86_64 -accel kvm -m 2048 -smp 2 -qmp stdio -name primary \
> +  -device piix3-usb-uhci -vnc :7 \
>    -device usb-tablet -netdev tap,id=hn0,vhost=off \
>    -device virtio-net-pci,id=net-pci0,netdev=hn0 \
>    -drive if=virtio,id=primary-disk0,driver=quorum,read-pattern=fifo,vote-threshold=1,\
>           children.0.file.filename=1.raw,\
>           children.0.driver=raw -S
>  Secondary:
> -# qemu-kvm -enable-kvm -m 2048 -smp 2 -qmp stdio -vnc :7 -name secondary \
> -  -device piix3-usb-uhci \
> +# qemu-system-x86_64 -accel kvm -m 2048 -smp 2 -qmp stdio -name secondary \
> +  -device piix3-usb-uhci -vnc :7 \
>    -device usb-tablet -netdev tap,id=hn0,vhost=off \
>    -device virtio-net-pci,id=net-pci0,netdev=hn0 \
>    -drive if=none,id=secondary-disk0,file.filename=1.raw,driver=raw,node-name=node0 \
> diff --git a/docs/can.txt b/docs/can.txt
> index a357105..7ba23b2 100644
> --- a/docs/can.txt
> +++ b/docs/can.txt
> @@ -52,7 +52,7 @@ The ''kvaser_pci'' board/device model is compatible with and has been tested wit
>  The tested setup was Linux 4.9 kernel on the host and guest side.
>  Example for qemu-system-x86_64:
>  
> -    qemu-system-x86_64 -enable-kvm -kernel /boot/vmlinuz-4.9.0-4-amd64 \
> +    qemu-system-x86_64 -accel kvm -kernel /boot/vmlinuz-4.9.0-4-amd64 \
>        -initrd ramdisk.cpio \
>        -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
>        -object can-bus,id=canbus0 \
> @@ -104,4 +104,4 @@ Links to other resources
>       Slides
>       http://rtime.felk.cvut.cz/publications/public/rtlws2015-qemu-can-slides.pdf
>   (5) Linux SocketCAN utilities
> -     https://github.com/linux-can/can-utils/
> \ No newline at end of file
> +     https://github.com/linux-can/can-utils/
> diff --git a/docs/multi-thread-compression.txt b/docs/multi-thread-compression.txt
> index d0caaf7..bb88c6b 100644
> --- a/docs/multi-thread-compression.txt
> +++ b/docs/multi-thread-compression.txt
> @@ -62,7 +62,7 @@ RAM: 128G
>  NIC: Intel I350 (10/100/1000Mbps)
>  Host OS: CentOS 7 64-bit
>  Guest OS: RHEL 6.5 64-bit
> -Parameter: qemu-system-x86_64 -enable-kvm -smp 4 -m 4096
> +Parameter: qemu-system-x86_64 -accel kvm -smp 4 -m 4096
>   /share/ia32e_rhel6u5.qcow -monitor stdio
>  
>  There is no additional application is running on the guest when doing
> diff --git a/docs/multiseat.txt b/docs/multiseat.txt
> index 807518c..dc28cdb 100644
> --- a/docs/multiseat.txt
> +++ b/docs/multiseat.txt
> @@ -18,7 +18,7 @@ or
>  
>  Next put together the qemu command line (sdk/gtk):
>  
> -qemu	-enable-kvm -usb $memory $disk $whatever \
> +qemu	-accel kvm -usb $memory $disk $whatever \
>  	-display [ sdl | gtk ] \
>  	-vga std \
>  	-device usb-tablet
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index c230c4c..70ad4a0 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -98,7 +98,7 @@ QEMU files related to the TPM passthrough device:
>  Command line to start QEMU with the TPM passthrough device using the host's
>  hardware TPM /dev/tpm0:
>  
> -qemu-system-x86_64 -display sdl -enable-kvm \
> +qemu-system-x86_64 -display sdl -accel kvm \
>    -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
>    -tpmdev passthrough,id=tpm0,path=/dev/tpm0 \
>    -device tpm-tis,tpmdev=tpm0 test.img
> @@ -164,7 +164,7 @@ swtpm socket --tpmstate dir=/tmp/mytpm1 \
>  Command line to start QEMU with the TPM emulator device communicating with
>  the swtpm:
>  
> -qemu-system-x86_64 -display sdl -enable-kvm \
> +qemu-system-x86_64 -display sdl -accel kvm \
>    -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
>    -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>    -tpmdev emulator,id=tpm0,chardev=chrtpm \
> @@ -222,7 +222,7 @@ swtpm socket --tpmstate dir=/tmp/mytpm1 \
>  
>  In a 2nd terminal start the VM:
>  
> -qemu-system-x86_64 -display sdl -enable-kvm \
> +qemu-system-x86_64 -display sdl -accel kvm \
>    -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
>    -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>    -tpmdev emulator,id=tpm0,chardev=chrtpm \
> @@ -255,7 +255,7 @@ swtpm socket --tpmstate dir=/tmp/mytpm1 \
>  In the 2nd terminal restore the state of the VM using the additonal
>  '-incoming' option.
>  
> -qemu-system-x86_64 -display sdl -enable-kvm \
> +qemu-system-x86_64 -display sdl -accel kvm \
>    -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
>    -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>    -tpmdev emulator,id=tpm0,chardev=chrtpm \
> diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
> index d648aeb..8c37bd3 100644
> --- a/hw/block/dataplane/virtio-blk.c
> +++ b/hw/block/dataplane/virtio-blk.c
> @@ -190,8 +190,8 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
>      /* Set up guest notifier (irq) */
>      r = k->set_guest_notifiers(qbus->parent, nvqs, true);
>      if (r != 0) {
> -        fprintf(stderr, "virtio-blk failed to set guest notifier (%d), "
> -                "ensure -enable-kvm is set\n", r);
> +        error_report("virtio-blk failed to set guest notifier (%d), "
> +                     "ensure -accel kvm is set.", r);
>          goto fail_guest_notifiers;
>      }
>  
> diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
> index 912e500..b995bab 100644
> --- a/hw/scsi/virtio-scsi-dataplane.c
> +++ b/hw/scsi/virtio-scsi-dataplane.c
> @@ -142,8 +142,8 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
>      /* Set up guest notifier (irq) */
>      rc = k->set_guest_notifiers(qbus->parent, vs->conf.num_queues + 2, true);
>      if (rc != 0) {
> -        fprintf(stderr, "virtio-scsi: Failed to set guest notifiers (%d), "
> -                "ensure -enable-kvm is set\n", rc);
> +        error_report("virtio-scsi: Failed to set guest notifiers (%d), "
> +                     "ensure -accel kvm is set.", rc);
>          goto fail_guest_notifiers;
>      }
>  
> 

Queued this one.  Thanks,

Paolo
