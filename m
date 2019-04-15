Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E680C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003332077C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003332077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51185 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG2o8-0004FS-Rp
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:42:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hG2nH-0003lO-W1
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hG2nG-0008UW-4X
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:41:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60818
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hG2nF-0008U3-QC
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:41:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FEYudm116955
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 10:41:06 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rvuk0h7g6-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 10:41:06 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Mon, 15 Apr 2019 15:41:05 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
	by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 15 Apr 2019 15:41:02 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3FEf0I823527444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 15 Apr 2019 14:41:01 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA8B1BE054;
	Mon, 15 Apr 2019 14:41:00 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 188FFBE051;
	Mon, 15 Apr 2019 14:41:00 +0000 (GMT)
Received: from [9.60.85.4] (unknown [9.60.85.4])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2019 14:40:59 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-5-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 15 Apr 2019 10:40:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190301093902.27799-5-cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041514-0020-0000-0000-00000ED7E525
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010932; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01189465; UDB=6.00623221;
	IPR=6.00970251; 
	MB=3.00026452; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 14:41:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041514-0021-0000-0000-000065711C59
Message-Id: <9d692710-cf9e-99c6-45d1-bb18a2ba7b94@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-15_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904150101
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v4 4/6] vfio-ccw: add capabilities chain
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415144059.Y2KFFQ-jJ0PX26MLds3RsK_duVxTdMkkTHWviKPCqW8@z>



On 3/1/19 4:39 AM, Cornelia Huck wrote:
> Allow to extend the regions used by vfio-ccw. The first user will be
> handling of halt and clear subchannel.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> ---
>   drivers/s390/cio/vfio_ccw_ops.c     | 186 ++++++++++++++++++++++++----
>   drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
>   include/uapi/linux/vfio.h           |   2 +
>   3 files changed, 200 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 025c8a832bc8..3fd663320bbf 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -3,13 +3,16 @@
>    * Physical device callbacks for vfio_ccw
>    *
>    * Copyright IBM Corp. 2017
> + * Copyright Red Hat, Inc. 2019
>    *
>    * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>    *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> + *            Cornelia Huck <cohuck@redhat.com>
>    */
>   
>   #include <linux/vfio.h>
>   #include <linux/mdev.h>
> +#include <linux/nospec.h>
>   
>   #include "vfio_ccw_private.h"
>   
> @@ -157,27 +160,33 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
>   {
>   	struct vfio_ccw_private *private =
>   		dev_get_drvdata(mdev_parent_dev(mdev));
> +	int i;
>   
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>   				 &private->nb);
> +
> +	for (i = 0; i < private->num_regions; i++)
> +		private->region[i].ops->release(private, &private->region[i]);
> +
> +	private->num_regions = 0;
> +	kfree(private->region);
> +	private->region = NULL;
>   }
>   
> -static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
> -				  char __user *buf,
> -				  size_t count,
> -				  loff_t *ppos)
> +static ssize_t vfio_ccw_mdev_read_io_region(struct vfio_ccw_private *private,
> +					    char __user *buf, size_t count,
> +					    loff_t *ppos)
>   {
> -	struct vfio_ccw_private *private;
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
>   	struct ccw_io_region *region;
>   	int ret;
>   
> -	if (*ppos + count > sizeof(*region))
> +	if (pos + count > sizeof(*region))
>   		return -EINVAL;
>   
> -	private = dev_get_drvdata(mdev_parent_dev(mdev));
>   	mutex_lock(&private->io_mutex);
>   	region = private->io_region;
> -	if (copy_to_user(buf, (void *)region + *ppos, count))
> +	if (copy_to_user(buf, (void *)region + pos, count))
>   		ret = -EFAULT;
>   	else
>   		ret = count;
> @@ -185,24 +194,47 @@ static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
>   	return ret;
>   }
>   
> -static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> -				   const char __user *buf,
> -				   size_t count,
> -				   loff_t *ppos)
> +static ssize_t vfio_ccw_mdev_read(struct mdev_device *mdev,
> +				  char __user *buf,
> +				  size_t count,
> +				  loff_t *ppos)
>   {
> +	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
>   	struct vfio_ccw_private *private;
> +
> +	private = dev_get_drvdata(mdev_parent_dev(mdev));
> +
> +	if (index >= VFIO_CCW_NUM_REGIONS + private->num_regions)
> +		return -EINVAL;
> +
> +	switch (index) {
> +	case VFIO_CCW_CONFIG_REGION_INDEX:
> +		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
> +	default:
> +		index -= VFIO_CCW_NUM_REGIONS;
> +		return private->region[index].ops->read(private, buf, count,
> +							ppos);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
> +					     const char __user *buf,
> +					     size_t count, loff_t *ppos)
> +{
> +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
>   	struct ccw_io_region *region;
>   	int ret;
>   
> -	if (*ppos + count > sizeof(*region))
> +	if (pos + count > sizeof(*region))
>   		return -EINVAL;
>   
> -	private = dev_get_drvdata(mdev_parent_dev(mdev));
>   	if (!mutex_trylock(&private->io_mutex))
>   		return -EAGAIN;
>   
>   	region = private->io_region;
> -	if (copy_from_user((void *)region + *ppos, buf, count)) {
> +	if (copy_from_user((void *)region + pos, buf, count)) {
>   		ret = -EFAULT;
>   		goto out_unlock;
>   	}
> @@ -217,19 +249,52 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>   	return ret;
>   }
>   
> -static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info)
> +static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> +				   const char __user *buf,
> +				   size_t count,
> +				   loff_t *ppos)
>   {
> +	unsigned int index = VFIO_CCW_OFFSET_TO_INDEX(*ppos);
> +	struct vfio_ccw_private *private;
> +
> +	private = dev_get_drvdata(mdev_parent_dev(mdev));
> +
> +	if (index >= VFIO_CCW_NUM_REGIONS + private->num_regions)
> +		return -EINVAL;
> +
> +	switch (index) {
> +	case VFIO_CCW_CONFIG_REGION_INDEX:
> +		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
> +	default:
> +		index -= VFIO_CCW_NUM_REGIONS;
> +		return private->region[index].ops->write(private, buf, count,
> +							 ppos);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int vfio_ccw_mdev_get_device_info(struct vfio_device_info *info,
> +					 struct mdev_device *mdev)
> +{
> +	struct vfio_ccw_private *private;
> +
> +	private = dev_get_drvdata(mdev_parent_dev(mdev));
>   	info->flags = VFIO_DEVICE_FLAGS_CCW | VFIO_DEVICE_FLAGS_RESET;
> -	info->num_regions = VFIO_CCW_NUM_REGIONS;
> +	info->num_regions = VFIO_CCW_NUM_REGIONS + private->num_regions;
>   	info->num_irqs = VFIO_CCW_NUM_IRQS;
>   
>   	return 0;
>   }
>   
>   static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
> -					 u16 *cap_type_id,
> -					 void **cap_type)
> +					 struct mdev_device *mdev,
> +					 unsigned long arg)
>   {
> +	struct vfio_ccw_private *private;
> +	int i;
> +
> +	private = dev_get_drvdata(mdev_parent_dev(mdev));
>   	switch (info->index) {
>   	case VFIO_CCW_CONFIG_REGION_INDEX:
>   		info->offset = 0;
> @@ -237,9 +302,55 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
>   		info->flags = VFIO_REGION_INFO_FLAG_READ
>   			      | VFIO_REGION_INFO_FLAG_WRITE;
>   		return 0;
> -	default:
> -		return -EINVAL;
> +	default: /* all other regions are handled via capability chain */
> +	{
> +		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> +		struct vfio_region_info_cap_type cap_type = {
> +			.header.id = VFIO_REGION_INFO_CAP_TYPE,
> +			.header.version = 1 };
> +		int ret;
> +
> +		if (info->index >=
> +		    VFIO_CCW_NUM_REGIONS + private->num_regions)
> +			return -EINVAL;
> +
> +		info->index = array_index_nospec(info->index,
> +						 VFIO_CCW_NUM_REGIONS +
> +						 private->num_regions);
> +
> +		i = info->index - VFIO_CCW_NUM_REGIONS;
> +
> +		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
> +		info->size = private->region[i].size;
> +		info->flags = private->region[i].flags;
> +
> +		cap_type.type = private->region[i].type;
> +		cap_type.subtype = private->region[i].subtype;
> +
> +		ret = vfio_info_add_capability(&caps, &cap_type.header,
> +					       sizeof(cap_type));
> +		if (ret)
> +			return ret;
> +
> +		info->flags |= VFIO_REGION_INFO_FLAG_CAPS;
> +		if (info->argsz < sizeof(*info) + caps.size) {
> +			info->argsz = sizeof(*info) + caps.size;
> +			info->cap_offset = 0;
> +		} else {
> +			vfio_info_cap_shift(&caps, sizeof(*info));
> +			if (copy_to_user((void __user *)arg + sizeof(*info),
> +					 caps.buf, caps.size)) {
> +				kfree(caps.buf);
> +				return -EFAULT;
> +			}
> +			info->cap_offset = sizeof(*info);
> +		}
> +
> +		kfree(caps.buf);
> +
> +	}
>   	}
> +	return 0;
>   }
>   
>   static int vfio_ccw_mdev_get_irq_info(struct vfio_irq_info *info)
> @@ -316,6 +427,32 @@ static int vfio_ccw_mdev_set_irqs(struct mdev_device *mdev,
>   	}
>   }
>   
> +int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
> +				 unsigned int subtype,
> +				 const struct vfio_ccw_regops *ops,
> +				 size_t size, u32 flags, void *data)
> +{
> +	struct vfio_ccw_region *region;
> +
> +	region = krealloc(private->region,
> +			  (private->num_regions + 1) * sizeof(*region),
> +			  GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	private->region = region;
> +	private->region[private->num_regions].type = VFIO_REGION_TYPE_CCW;
> +	private->region[private->num_regions].subtype = subtype;
> +	private->region[private->num_regions].ops = ops;
> +	private->region[private->num_regions].size = size;
> +	private->region[private->num_regions].flags = flags;
> +	private->region[private->num_regions].data = data;
> +
> +	private->num_regions++;
> +
> +	return 0;
> +}
> +
>   static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
>   				   unsigned int cmd,
>   				   unsigned long arg)
> @@ -336,7 +473,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
>   		if (info.argsz < minsz)
>   			return -EINVAL;
>   
> -		ret = vfio_ccw_mdev_get_device_info(&info);
> +		ret = vfio_ccw_mdev_get_device_info(&info, mdev);
>   		if (ret)
>   			return ret;
>   
> @@ -345,8 +482,6 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
>   	case VFIO_DEVICE_GET_REGION_INFO:
>   	{
>   		struct vfio_region_info info;
> -		u16 cap_type_id = 0;
> -		void *cap_type = NULL;
>   
>   		minsz = offsetofend(struct vfio_region_info, offset);
>   
> @@ -356,8 +491,7 @@ static ssize_t vfio_ccw_mdev_ioctl(struct mdev_device *mdev,
>   		if (info.argsz < minsz)
>   			return -EINVAL;
>   
> -		ret = vfio_ccw_mdev_get_region_info(&info, &cap_type_id,
> -						    &cap_type);
> +		ret = vfio_ccw_mdev_get_region_info(&info, mdev, arg);
>   		if (ret)
>   			return ret;
>   
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 32173cbd838d..d888a2573470 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -3,9 +3,11 @@
>    * Private stuff for vfio_ccw driver
>    *
>    * Copyright IBM Corp. 2017
> + * Copyright Red Hat, Inc. 2019
>    *
>    * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>    *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> + *            Cornelia Huck <cohuck@redhat.com>
>    */
>   
>   #ifndef _VFIO_CCW_PRIVATE_H_
> @@ -19,6 +21,38 @@
>   #include "css.h"
>   #include "vfio_ccw_cp.h"
>   
> +#define VFIO_CCW_OFFSET_SHIFT   10
> +#define VFIO_CCW_OFFSET_TO_INDEX(off)	(off >> VFIO_CCW_OFFSET_SHIFT)
> +#define VFIO_CCW_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_CCW_OFFSET_SHIFT)
> +#define VFIO_CCW_OFFSET_MASK	(((u64)(1) << VFIO_CCW_OFFSET_SHIFT) - 1)
> +
> +/* capability chain handling similar to vfio-pci */
> +struct vfio_ccw_private;
> +struct vfio_ccw_region;
> +
> +struct vfio_ccw_regops {
> +	ssize_t	(*read)(struct vfio_ccw_private *private, char __user *buf,
> +			size_t count, loff_t *ppos);
> +	ssize_t	(*write)(struct vfio_ccw_private *private,
> +			 const char __user *buf, size_t count, loff_t *ppos);
> +	void	(*release)(struct vfio_ccw_private *private,
> +			   struct vfio_ccw_region *region);
> +};
> +
> +struct vfio_ccw_region {
> +	u32				type;
> +	u32				subtype;
> +	const struct vfio_ccw_regops	*ops;
> +	void				*data;
> +	size_t				size;
> +	u32				flags;
> +};
> +
> +int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
> +				 unsigned int subtype,
> +				 const struct vfio_ccw_regops *ops,
> +				 size_t size, u32 flags, void *data);
> +
>   /**
>    * struct vfio_ccw_private
>    * @sch: pointer to the subchannel
> @@ -29,6 +63,8 @@
>    * @nb: notifier for vfio events
>    * @io_region: MMIO region to input/output I/O arguments/results
>    * @io_mutex: protect against concurrent update of I/O regions
> + * @region: additional regions for other subchannel operations
> + * @num_regions: number of additional regions
>    * @cp: channel program for the current I/O operation
>    * @irb: irb info received from interrupt
>    * @scsw: scsw info
> @@ -44,6 +80,8 @@ struct vfio_ccw_private {
>   	struct notifier_block	nb;
>   	struct ccw_io_region	*io_region;
>   	struct mutex		io_mutex;
> +	struct vfio_ccw_region *region;
> +	int num_regions;
>   
>   	struct channel_program	cp;
>   	struct irb		irb;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 02bb7ad6e986..56e2413d3e00 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -353,6 +353,8 @@ struct vfio_region_gfx_edid {
>   #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>   };
>   
> +#define VFIO_REGION_TYPE_CCW			(2)
> +
>   /*
>    * 10de vendor sub-type
>    *
> 


