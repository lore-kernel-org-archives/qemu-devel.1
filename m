Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E475C3403C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A3021D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A3021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43OL-00010a-It
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1j43Nd-0000YE-Os
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1j43Nc-0005Ud-L3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:57:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8120
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1j43Nc-0005UH-FE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:57:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01IDsfJU123641
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:57:39 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y7uaguqjv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 08:57:39 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Tue, 18 Feb 2020 13:57:37 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 18 Feb 2020 13:57:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01IDvWAJ46465074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Feb 2020 13:57:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17ABF42041;
 Tue, 18 Feb 2020 13:57:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF67D42045;
 Tue, 18 Feb 2020 13:57:31 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.41])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 18 Feb 2020 13:57:31 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] docs: rstfy vfio-ap documentation
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200213162942.14177-1-cohuck@redhat.com>
 <20200213162942.14177-3-cohuck@redhat.com>
 <d0fb1979-7041-e21e-29f1-a38e3f2dd7e9@linux.ibm.com>
 <CAFEAcA8JQN8zDczCEarYxngEWsgQ84zCicmWBu=+E5vFe6U7Qg@mail.gmail.com>
 <20200218134451.23c77b1f.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 18 Feb 2020 14:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218134451.23c77b1f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021813-0012-0000-0000-00000387FB71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021813-0013-0000-0000-000021C48BC9
Message-Id: <73579e24-3a2f-e4d1-2fd8-3470e5aec694@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-18_02:2020-02-17,
 2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020-02-18 13:44, Cornelia Huck wrote:
> On Thu, 13 Feb 2020 18:54:37 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Thu, 13 Feb 2020 at 18:38, Pierre Morel <pmorel@linux.ibm.com>
>> wrote:> However it may be because I do not use the right tools.
>>> Did not find which one I am suppose to use.
>>> Currently using:
>>> rst2latex vfio-ap.rst > vfio-ap.tex && pdflatex vfio-ap.tex
>>
>> The only supported way to build the docs is with Sphinx.
>>
>> Option 1:
>>
>> If you have the right versions of the tools installed
>> then running "make" in the usual way will build HTML docs
>> into the docs/ subdirectory of your build directory.
>> Passing --enable-docs to configure will cause it to complain
>> if you're missing a tool rather than silently not building
>> the docs. This is what we expect most users to be doing.
>>
>> Option 2:
>>
>> You can run Sphinx 'manually' with something like
>>   sphinx-build docs /tmp/sphinx-out
>> which will build a single big fat manual into the
>> specified output directory (here /tmp/sphinx-out).
>> This option is provided mostly so that sites like
>> 'readthedocs' can produce the documentation without having
>> to run our Makefiles.
>>
>> PDF is not an officially supported (by us) output format,
>> but if you really want it you can generate it with
>>   sphinx-build -b latex docs /tmp/sphinx-out
>>   cd /tmp/sphinx-out
>>   make
>> which will generate a QEMU.pdf in /tmp/sphinx-out.
>>
>> We're unlikely to want to make tweaks to the documentation
>> sources to fix infelicities in the formatting of the PDF,
>> though.
> 
> FWIW, using option 2 to produce a pdf seems to end up with something
> decent-looking with these patches applied. (Lots of warnings from
> LaTex, but that seems preexisting.)
> 

OK, then I effectively did not use the right tools. Sorry for this and 
thanks for having leaning again.

For the content I was OK with all so:
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

and thanks for the work.




-- 
Pierre Morel
IBM Lab Boeblingen


