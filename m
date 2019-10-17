Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2732ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1D120869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1D120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLBPN-0001OC-R5
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iLBOf-0000rX-8y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 15:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cheloha@linux.vnet.ibm.com>) id 1iLBOd-0000jr-RI
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 15:25:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cheloha@linux.vnet.ibm.com>)
 id 1iLBOd-0000jA-Iy
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 15:25:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9HJHePQ098350
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:25:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vpv30dk4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:25:11 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9HJIFqX100365
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:25:11 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vpv30dk4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 15:25:10 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HJEoYO024785;
 Thu, 17 Oct 2019 19:25:10 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma04dal.us.ibm.com with ESMTP id 2vk6f84pes-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 19:25:09 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9HJP9nA46531058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2019 19:25:09 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17333AC060;
 Thu, 17 Oct 2019 19:25:09 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E30C6AC064;
 Thu, 17 Oct 2019 19:25:08 +0000 (GMT)
Received: from localhost (unknown [9.41.179.32])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2019 19:25:08 +0000 (GMT)
Date: Thu, 17 Oct 2019 14:25:08 -0500
From: Scott Cheloha <cheloha@linux.vnet.ibm.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] migration: savevm_state_insert_handler: constant-time
 element insertion
Message-ID: <20191017192508.nwa2a34hzen3xgnr@rascal.austin.ibm.com>
References: <20191016164156.4506-1-cheloha@linux.vnet.ibm.com>
 <87lftjpxsz.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lftjpxsz.fsf@trasno.org>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170173
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 10:43:08AM +0200, Juan Quintela wrote:
> Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:
> 
> > Registering a SaveStateEntry object via savevm_state_insert_handler()
> > is an O(n) operation because the list is a priority queue maintained by
> > walking the list from head to tail to find a suitable insertion point.
> >
> > This adds considerable overhead for VMs with many such objects.  For
> > instance, ppc64 machines with large maxmem (8T+) spend ~10% or more of
> > their CPU time in savevm_state_insert_handler() before attempting to
> > boot a kernel.
> 
> Ouch ...
> 
> > If we track the head for each priority's subqueue we can insert new
> > elements in constant time.
> 
> We are adding a subqueue by priority, right? (see later comments)

One already exists.  This patch would just make insertion way, way
faster by memoizing the subqueue heads.

> > This commit also introduces a new function,
> > savevm_state_remove_handler(),
> 
> savevm_state_handler_remove()
> 
> search didn't find it O:-)

Whoops, my bad, will fix the commit message for v2.

> > which abstracts the logic for replacing the head of an element's subqueue
> > when removing it.
> 
> I think that it is better if you split the new function creation.  Make
> commit easier to write O:-)

Sure, I'll do that in the v2 patch in the next mail.

> >  static SaveState savevm_state = {
> >      .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
> > +    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },
> 
> Why are you still maintaining the handlers QTAILQ?  Once here will not
> be easier to just change handlers field to be an array
> handlers[MIG_PRI_MAX] field, and adjust callers?
> 
> Changes are only inside this file.
> 
> The code to maintain the subqueue inside the other queue is just as
> complex as chaning all the callers.  What do you think?

I was trying to avoid churning the file more than absolutely
necessary.  There are 18 QTAILQ_FOREACH() loops in savevm.c right now.
Making ~15 of them double-loops doesn't make the code easier to read.

I think incurring slight complexity on insertion/removal to make
insertion fast is well worth the conceptual simplicity of addressing
one big list of elements for every other operation.

> savevm_state_handler_insert() for instance becomes even easier, just a
> QTALIQ_INSERT_TAIL() in the proper queue, right?

Yes, insertion becomes extremely obvious: you just append the element
to the tail of its priority queue, which must already exist.

But see above for the cost.

> I agree with the idea of the patch.  Especially when you told us how bad
> the performance of the current code is.
> 
> Out of curiosity, how many objects are we talking about?

At maxmem=8T I'm seeing about 40000 elements in that list.  At
maxmem=64T I'm seeing around 262000.  The vast majority of these
elements are "spapr_drc" objects, each of which (IIRC) corresponds to
a 256MB chunk of address space.

