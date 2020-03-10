Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246EC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8C721D56
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZARFedu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8C721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBj9q-0003HD-Iw
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBj99-0002c7-Ng
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBj97-0001Lo-KY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:58:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBj97-0001H5-BK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:58:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AHrMMl144335;
 Tue, 10 Mar 2020 17:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HV8Iwr0DteVjS3q2TLJELwn0PySRl/nA9TwjoDkVA0g=;
 b=NZARFeduMn/NczJUshMzNElhNXfEQuWkqSFtVEbtK4wzpXHEHQYfVAL4X/cl+u+m4Dnu
 pzpqqWnEl1voBtJqzr3mcPJG8jz2NBsMe0mNAls7BHuRV0/o3CSFR3GotAcCHAfqwcG+
 SkO/RmpuaQMa/VzSw3Nso3I3N+GRNS4U7Fi8DN9wU9/0GGBOVecSHRjTP9PJQCIzJ9DK
 VkvxiIzIdu167Zr1W7O+Xbv1t016/EJxWKeWZvh3cDQ0VH5hSGueZ5RkbEsUxX9uLkmw
 tjqn6harGEoNIXxs2LJdoHHSTuv6PWSpGwju0k8w3Ppoz5aLdTCD52tMtQ+2lyI5UxBk qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yp7hm3h60-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 17:58:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AHrGMP015816;
 Tue, 10 Mar 2020 17:58:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2yp8qpjmpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 17:58:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AHwKiV010786;
 Tue, 10 Mar 2020 17:58:20 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 10:58:20 -0700
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
 <20200310104713-mutt-send-email-mst@kernel.org>
 <8c856884-a5f1-d522-b0be-9edee6623ca4@oracle.com>
 <20200310125426-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <e44d7551-d888-9a96-fb26-2b71b7bfdf01@oracle.com>
Date: Tue, 10 Mar 2020 19:58:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310125426-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100108
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 19:36, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 06:39:33PM +0200, Liran Alon wrote:
>>>> Isn't enum invented exactly for enumerating all possible values of a field?
>>> No - it just assigns names to constants. If you then proceed not to use
>>> the names, then it's pointless.
>> It's not. It exactly lists all the various possible values.
> That's not factually correct in this case. In C, enum does not
> necessarily list all possible values generally. Neither is it always
> used like this in QEMU. Neither does it do it in this case, nothing
> prevents user from sticking any single-byte value in the property.
It lists all currently known values for this enum. Exactly as you do in 
your comment...
The only way to prevent user from entering a value that is not defined 
in enum is to restrict user to enum-values.
Which can be done if you think it's appropriate. I think it just limits 
production flexibility.
>
>> Giving new names to existing terminology that can be matched against
>> existing guest code which interface with your device emulation is what
>> requires guesswork.
>> Using names matching the guest code driver is what doesn't require guesswork
>> and is more intuitive to understand.
> Yes, it's sometimes helpful to match guest driver since that helps debug
> the whole stack. There's literally nothing to help debug here though.
The "guest driver" in this case is open-vm-tools. And it helps that the 
names match.
> But if you feel strongly, here's a conversation starter.
> But it raises some questions that need to be answered
> properly:
>
>
> /*
>   * Virtual Machine eXecutable type (VMX).
>   *
>   * Most guests are fine with the default.
>   *
>   * Some legacy guests hard-code a given type.
>
> ^ Is this the real reason we are including this option?
> Because if it is how is it helpful to add link to
> the open-source drivers? These likely are not legacy ...
The "driver" in this case is open-vm-tools.
The legacy guests have proprietary drivers that mimics VMware Tools or a 
subset of it's functionality.
>
>
>   * See https://urldefense.com/v3/__https://github.com/vmware/open-vm-tools/blob/master/open-vm-tools/lib/include/vm_vmx_type.h__;!!GqivPVa7Brio!IuRMdod4d33nvVKOiG-itVXtxnHA9nAouQdYDxv3E62rIzVzPBWZ5M54D7BEF3g$
>   * for an up-to-date list of values.
>   * To help locate relevant portions of guest driver code
>   * and debug guest failures, enum names from the above header
>   * are listed below:
>   *
>   * Reasonable options:
>   * 0 - unset? - see VMX_TYPE_UNSET
>
> 			^^^ Note as you know what this is, please write it up.
>
>   * 1 - VMware Express (deprecated) - see VMX_TYPE_UNSET
>   * 2 - VMware ESX server - see VMX_TYPE_EXPRESS
>   * 3 - VMware Server (deprecated) - see VMX_TYPE_WGS
>   * 4 - VMware Workstation - see VMX_TYPE_WORKSTATION
>   * 5 - ACE 1.x (deprecated) - see VMX_TYPE_WORKSTATION_ENTERPRISE
>   */
> DEFINE_PROP_UINT8("vm-executable-type", VMPortState, vm_executable_type, 2),
>
>
> Maybe above is OK, if above questions can be addressed.
I still don't understand why you view a comment to be better than an enum.
This also contradict the approach taken for other enums in device 
emulation code, as I have provided multiple examples in previous reply.
>
>
>
>> Let's agree that I will fix coding convention issue (VMX_Type -> VMXType)
>> and link to open-vm-tools but remain with the enum.
>> And see what other maintainers have to see about this on v2.
> Sorry, if you don't address my comments from v1 please do not expect me
> to review v2.  I also feel strongly about proper attribution.  Ignoring
> original license on vmport.c making it depend on "GPL v2 but not later"
> bits for cosmetic reasons just isn't right.

Which part of license to I ignore?

I fixed all the comments you have mentioned beside this thing that is 
debatable. I wish to hear an additional opinion.
If you really strongly insist on this, I can change this to what you 
want without further discussion...

Why not allow to review all the 15 patches besides a discussion of 
whether constants should be defined in enum or comment?
That seems a little harsh to me.

-Liran





