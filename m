Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11894C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FD120665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 18:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FD120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfTHB-0002Bz-Ci
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 14:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53165)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lvivier@redhat.com>) id 1hfTAv-0004OX-8v
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1hfTAs-0002aM-Ty
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hfTAs-0002YZ-2h
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:54:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D51C7356CA;
 Mon, 24 Jun 2019 17:54:35 +0000 (UTC)
Received: from [10.36.117.25] (ovpn-117-25.ams2.redhat.com [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 276C25C22F;
 Mon, 24 Jun 2019 17:54:28 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
 <20190320112646.3712-2-xieyongji@baidu.com>
 <20190524121909.277ae31e@bahia.lan>
 <CAONzpcbf+AcY4yEO6hBnyp1dBaV4XgUrSTdU55B3S+wcn6gOVA@mail.gmail.com>
 <20190527124446.6b809c7f@bahia.lan>
 <20190527145329-mutt-send-email-mst@kernel.org>
 <CAONzpcb6dtsnYhVW+yy0FijXtHoLavXX_bwStVEZC1hqJr9wSQ@mail.gmail.com>
 <20190531193633.GI22103@habkost.net>
 <20190601174941.00bf108f@bahia.lab.toulouse-stg.fr.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5e49e2e8-0753-67f0-d453-74d9dd8372ce@redhat.com>
Date: Mon, 24 Jun 2019 19:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190601174941.00bf108f@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 24 Jun 2019 17:54:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 04/36] virtio: Introduce started flag to
 VirtioDevice
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Yu <zhangyu31@baidu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Yongji Xie <elohimes@gmail.com>, Xie Yongji <xieyongji@baidu.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/06/2019 17:49, Greg Kurz wrote:
> On Fri, 31 May 2019 16:36:33 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
>> On Tue, May 28, 2019 at 10:48:09AM +0800, Yongji Xie wrote:
>>> On Tue, 28 May 2019 at 02:54, Michael S. Tsirkin <mst@redhat.com> wrote:  
>>>>
>>>> On Mon, May 27, 2019 at 12:44:46PM +0200, Greg Kurz wrote:  
>>>>> On Fri, 24 May 2019 19:56:06 +0800
>>>>> Yongji Xie <elohimes@gmail.com> wrote:
>>>>>  
>>>>>> On Fri, 24 May 2019 at 18:20, Greg Kurz <groug@kaod.org> wrote:  
>>>>>>>
>>>>>>> On Mon, 20 May 2019 19:10:35 -0400
>>>>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>>>>  
>>>>>>>> From: Xie Yongji <xieyongji@baidu.com>  
>> [...]
>>>>>>>> @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
>>>>>>>>      return vdev->broken;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +static bool virtio_started_needed(void *opaque)
>>>>>>>> +{
>>>>>>>> +    VirtIODevice *vdev = opaque;
>>>>>>>> +
>>>>>>>> +    return vdev->started;  
>>>>>>>
>>>>>>> Existing machine types don't know about the "virtio/started" subsection. This
>>>>>>> breaks migration to older QEMUs if the driver has started the device, ie. most
>>>>>>> probably always when it comes to live migration.
>>>>>>>
>>>>>>> My understanding is that we do try to support backward migration though. It
>>>>>>> is a regular practice in datacenters to migrate workloads without having to
>>>>>>> take care of the QEMU version. FWIW I had to fix similar issues downstream
>>>>>>> many times in the past because customers had filed bugs.
>>>>>>>  
>>>>>>
>>>>>> If we do need to support backward migration, for this patch, what I
>>>>>> can think of is to only migrate the flag in the case that guest kicks
>>>>>> but not set DRIVER_OK. This could fix backward migration in most case.  
>>>>>
>>>>> You mean something like that ?
>>>>>
>>>>> static bool virtio_started_needed(void *opaque)
>>>>> {
>>>>>     VirtIODevice *vdev = opaque;
>>>>>
>>>>>     return vdev->started && !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK);
>>>>> }
>>>>>  
>>>>>> Not sure if there is a more general approach...
>>>>>>  
>>>>>
>>>>> Another approach would be to only implement the started flag for
>>>>> machine version > 4.0. This can be achieved by adding a "use-started"
>>>>> property to the base virtio device, true by default and set to
>>>>> false by hw_compat_4_0.  
>>>>
>>>> I think this is best frankly.
>>>>  
>>>
>>> Only implement the started flag for machine version > 4.0 might not be
>>> good because vhost-user-blk now need to use this flag. How about only
>>> migrating this flag for machine version > 4.0 instead?  
>>
>> Was this implemented?  Is migration from QEMU 4.1 to QEMU 4.0
>> currently broken?
>>
> 
> Answer is yes for both questions.
> 

Is there a fix?

The problem is really easy to reproduce: start a guest with virtio-blk
and migrate once the driver has started.

Thanks,
Laurent

