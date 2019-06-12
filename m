Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C25C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4A020866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4A020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2oJ-0007ir-Ia
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hb2Qp-0001gK-Eu
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hb2Ql-000227-4m
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:32:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hb2Qh-0001vo-Hy
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:32:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so6339577wma.4
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 05:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mqp3msBOCufH0pE24Yxy/kWNBy0vvGDj87ptUcKLmC4=;
 b=KNY2K3eiOT4LPmAr3et2QiduRV8sjaGAPVCSdUbi1o94AlKDGYb6AQxJni0VtFm7UO
 4cA1fLFswXKSBV100CBVeuqX2SOYT8Jli68s8qDy14Hjx4NCxJ6WM7ILv0P8GTdQsPUo
 fy8G/YNYZQEWLG50m6LAbR1Bo2uYPIVlqWblCR3e4WbupqKbVTildQU9DF5lBdX+N+Jr
 b3Rr86b8Bs7I8nDeUNZPMC8N74y5WpqP4KKmUUINw+eJ0eL6p+y2dBOMNAQA0TynGKKN
 EDsDQcVB9nN3aVNZZw9evQBaOd9AnWS2H/IAmIITS7HxarkwcjrbXjE4bXR8dDhVFh6m
 bVsg==
X-Gm-Message-State: APjAAAVdTPy7w2ATb+T4ZOP15GtNasGxClgdnsZ+8RmhXiiDRwWF6mEU
 OvRgRzXZ2flXQw4QIdyj9ODexg==
X-Google-Smtp-Source: APXvYqyjXO02hhBnKwb9cfaC6jXDITSB7HfLoerYZhm3n49ukOi52afqJa1wlUCtOgxRO++y8X8QKQ==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr21818469wmh.165.1560342757948; 
 Wed, 12 Jun 2019 05:32:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d43d:6da3:9364:a775?
 ([2001:b07:6468:f312:d43d:6da3:9364:a775])
 by smtp.gmail.com with ESMTPSA id l190sm5935869wml.16.2019.06.12.05.32.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 05:32:37 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190612120421.20336-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <298bea90-7b26-6a07-3f3f-65dacaba9fe5@redhat.com>
Date: Wed, 12 Jun 2019 14:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612120421.20336-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v4] virtio-scsi: restart DMA after iothread
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/06/19 14:04, Stefan Hajnoczi wrote:
> When the 'cont' command resumes guest execution the vm change state
> handlers are invoked.  Unfortunately there is no explicit ordering
> between vm change state handlers.  When two layers of code both use vm
> change state handlers, we don't control which handler runs first.
> 
> virtio-scsi with iothreads hits a deadlock when a failed SCSI command is
> restarted and completes before the iothread is re-initialized.
> 
> This patch introduces priorities for VM change state handlers so the
> IOThread is guaranteed to be initialized before DMA requests are
> restarted.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v4:
> Paolo and Michael were interested in a priorities system.  Kevin wasn't
> convinced.  Here is a patch implementing the priorities approach so you
> can decide whether you prefer this or not.

I like this better than the others, but I do agree with Kevin that the
names aren't great and PRIO_IOTHREAD has nothing to do with iothreads
really.

Maybe the priority should be simply the "depth" of the device's bus, so
2 for scsi because we know it always has a controller between the device
and the machine and 1 for everything else.  Maybe who knows, in the
future the vmstate_change handler could be moved in DeviceClass and
propagated across buses[1]

So I vote for this patch but with VM_CHANGE_STATE_HANDLER_PRIO_IOTHREAD
renamed to VM_CHANGE_STATE_HANDLER_PRIO_DEVICE and
VM_CHANGE_STATE_HANDLER_PRIO_DEVICE renamed to
VM_CHANGE_STATE_HANDLER_PRIO_DISK (which is consistent with the naming
of scsi-disk, though not with ide-drive...).

Paolo

[1] With care, because currently the initialization order for stop is
virtio-device -> virtio-pci -> scsi-bus (and the opposite for start).  I
am not sure that the order for virtio-pci and virtio-device could be
exchanged, as would be the case if you followed the bus order
pci->virtio->scsi.

> The customer has now confirmed that the deadlock is fixed.  I have
> changed the Subject line from RFC to PATCH.
> 
>  include/sysemu/sysemu.h | 10 ++++++++++
>  hw/scsi/scsi-bus.c      |  6 ++++--
>  hw/virtio/virtio.c      |  6 ++++--
>  vl.c                    | 44 +++++++++++++++++++++++++++++++----------
>  4 files changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 61579ae71e..1a4db092c7 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -27,8 +27,18 @@ bool runstate_store(char *str, size_t size);
>  typedef struct vm_change_state_entry VMChangeStateEntry;
>  typedef void VMChangeStateHandler(void *opaque, int running, RunState state);
>  
> +enum {
> +    /* Low priorities run first when the VM starts */
> +    VM_CHANGE_STATE_HANDLER_PRIO_UNDEFINED = 0,
> +    VM_CHANGE_STATE_HANDLER_PRIO_IOTHREAD = 100,
> +    VM_CHANGE_STATE_HANDLER_PRIO_DEVICE = 200,
> +    /* High priorities run first when the VM stops */
> +};
> +
>  VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>                                                       void *opaque);
> +VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
> +        VMChangeStateHandler *cb, void *opaque, int priority);
>  void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>  void vm_state_notify(int running, RunState state);
>  
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index c480553083..eda5b9a19e 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -206,8 +206,10 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    dev->vmsentry = qemu_add_vm_change_state_handler(scsi_dma_restart_cb,
> -                                                     dev);
> +    dev->vmsentry = qemu_add_vm_change_state_handler_prio(
> +            scsi_dma_restart_cb,
> +            dev,
> +            VM_CHANGE_STATE_HANDLER_PRIO_DEVICE);
>  }
>  
>  static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 07f4a64b48..9256af587a 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2354,8 +2354,10 @@ void virtio_init(VirtIODevice *vdev, const char *name,
>      } else {
>          vdev->config = NULL;
>      }
> -    vdev->vmstate = qemu_add_vm_change_state_handler(virtio_vmstate_change,
> -                                                     vdev);
> +    vdev->vmstate = qemu_add_vm_change_state_handler_prio(
> +            virtio_vmstate_change,
> +            vdev,
> +            VM_CHANGE_STATE_HANDLER_PRIO_IOTHREAD);
>      vdev->device_endian = virtio_default_endian();
>      vdev->use_guest_notifier_mask = true;
>  }
> diff --git a/vl.c b/vl.c
> index cd1fbc4cdc..26c82063d2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1469,27 +1469,45 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
>  struct vm_change_state_entry {
>      VMChangeStateHandler *cb;
>      void *opaque;
> -    QLIST_ENTRY (vm_change_state_entry) entries;
> +    QTAILQ_ENTRY (vm_change_state_entry) entries;
> +    int priority;
>  };
>  
> -static QLIST_HEAD(, vm_change_state_entry) vm_change_state_head;
> +static QTAILQ_HEAD(, vm_change_state_entry) vm_change_state_head;
>  
> -VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
> -                                                     void *opaque)
> +VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
> +        VMChangeStateHandler *cb, void *opaque, int priority)
>  {
>      VMChangeStateEntry *e;
> +    VMChangeStateEntry *other;
>  
>      e = g_malloc0(sizeof (*e));
> -
>      e->cb = cb;
>      e->opaque = opaque;
> -    QLIST_INSERT_HEAD(&vm_change_state_head, e, entries);
> +    e->priority = priority;
> +
> +    /* Keep list sorted in ascending priority order */
> +    QTAILQ_FOREACH(other, &vm_change_state_head, entries) {
> +        if (priority < other->priority) {
> +            QTAILQ_INSERT_BEFORE(other, e, entries);
> +            return e;
> +        }
> +    }
> +
> +    QTAILQ_INSERT_TAIL(&vm_change_state_head, e, entries);
>      return e;
>  }
>  
> +VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
> +                                                     void *opaque)
> +{
> +    return qemu_add_vm_change_state_handler_prio(cb, opaque,
> +            VM_CHANGE_STATE_HANDLER_PRIO_UNDEFINED);
> +}
> +
>  void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
>  {
> -    QLIST_REMOVE (e, entries);
> +    QTAILQ_REMOVE (&vm_change_state_head, e, entries);
>      g_free (e);
>  }
>  
> @@ -1499,8 +1517,14 @@ void vm_state_notify(int running, RunState state)
>  
>      trace_vm_state_notify(running, state, RunState_str(state));
>  
> -    QLIST_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
> -        e->cb(e->opaque, running, state);
> +    if (running) {
> +        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
> +            e->cb(e->opaque, running, state);
> +        }
> +    } else {
> +        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
> +            e->cb(e->opaque, running, state);
> +        }
>      }
>  }
>  
> @@ -3009,7 +3033,7 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>  
> -    QLIST_INIT (&vm_change_state_head);
> +    QTAILQ_INIT (&vm_change_state_head);
>      os_setup_early_signal_handling();
>  
>      cpu_option = NULL;
> 


