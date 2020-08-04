Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEF3206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEF3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uqk-0003Bq-Q4
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 07:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1k2uq9-0002g4-1b; Tue, 04 Aug 2020 07:10:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37038
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1k2uq6-0006KP-W5; Tue, 04 Aug 2020 07:10:40 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 074B1vbg040134; Tue, 4 Aug 2020 07:10:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32q5rj1cus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 07:10:36 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074B2Trf041761;
 Tue, 4 Aug 2020 07:10:35 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32q5rj1cu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 07:10:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074B9dxf028921;
 Tue, 4 Aug 2020 11:10:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 32n0183863-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 11:10:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 074B94Rg59965806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2020 11:09:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 268D852057;
 Tue,  4 Aug 2020 11:10:31 +0000 (GMT)
Received: from ibm-vm (unknown [9.145.12.119])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9C2315204F;
 Tue,  4 Aug 2020 11:10:30 +0000 (GMT)
Date: Tue, 4 Aug 2020 13:06:01 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 5/6] pc-bios/s390-ccw: Scan through all boot
 devices if none has been specified
Message-ID: <20200804130601.6656720b@ibm-vm>
In-Reply-To: <20200728183734.7838-6-thuth@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-6-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-04_03:2020-08-03,
 2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 07:10:36
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Jason J .
 Herne" <jjherne@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 20:37:33 +0200
Thomas Huth <thuth@redhat.com> wrote:

> If no boot device has been specified (via "bootindex=..."), the
> s390-ccw bios scans through all devices to find a bootable device.

maybe a better title for the patch is "scan through all devices if no
boot device specified" then, since it seems we will scan all
devices, not just "boot" devices?

> But so far, it stops at the very first block device (including
> virtio-scsi controllers without attached devices) that it finds, no
> matter whether it is bootable or not. That leads to some weird
> situatation where it is e.g. possible to boot via:
> 
>  qemu-system-s390x -hda /path/to/disk.qcow2
> 
> but not if there is e.g. a virtio-scsi controller specified before:
> 
>  qemu-system-s390x -device virtio-scsi -hda /path/to/disk.qcow2
> 
> While using "bootindex=..." is clearly the preferred way of booting
> on s390x, we still can make the life for the users at least a little
> bit easier if we look at all available devices to find a bootable one.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1846975
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c | 46
> +++++++++++++++++++++++++++-------------- 1 file changed, 31
> insertions(+), 15 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 3cd01cd80f..0af872f9e3 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -182,20 +182,8 @@ static void boot_setup(void)
>  static void find_boot_device(void)
>  {
>      VDev *vdev = virtio_get_device();
> -    int ssid;
>      bool found;
>  
> -    if (!have_iplb) {
> -        for (ssid = 0; ssid < 0x3; ssid++) {
> -            blk_schid.ssid = ssid;
> -            found = find_subch(-1);
> -            if (found) {
> -                return;
> -            }
> -        }
> -        panic("Could not find a suitable boot device (none
> specified)\n");
> -    }
> -
>      switch (iplb.pbt) {
>      case S390_IPL_TYPE_CCW:
>          debug_print_int("device no. ", iplb.ccw.devno);
> @@ -260,14 +248,42 @@ static void ipl_boot_device(void)
>      }
>  }
>  
> +/*
> + * No boot device has been specified, so we have to scan through the
> + * channels to find one.
> + */
> +static void probe_boot_device(void)
> +{
> +    int ssid, sch_no, ret;
> +
> +    for (ssid = 0; ssid < 0x3; ssid++) {
> +        blk_schid.ssid = ssid;
> +        for (sch_no = 0; sch_no < 0x10000; sch_no++) {
> +            ret = check_sch_no(-1, sch_no);
> +            if (ret < 0) {
> +                break;
> +            }
> +            if (ret == true) {
> +                ipl_boot_device();      /* Only returns if
> unsuccessful */
> +            }
> +        }
> +    }
> +
> +    sclp_print("Could not find a suitable boot device (none
> specified)\n"); +}
> +
>  int main(void)
>  {
>      sclp_setup();
>      css_setup();
>      boot_setup();
> -    find_boot_device();
> -    enable_subchannel(blk_schid);
> -    ipl_boot_device();
> +    if (have_iplb) {
> +        find_boot_device();
> +        enable_subchannel(blk_schid);
> +        ipl_boot_device();
> +    } else {
> +        probe_boot_device();
> +    }
>  
>      panic("Failed to load OS from hard disk\n");
>      return 0; /* make compiler happy */


