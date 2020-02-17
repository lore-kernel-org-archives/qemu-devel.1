Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1A5C35242
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 05:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AFB2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 05:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AFB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Z6J-0005CZ-PJ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 00:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1j3Z5d-0004lQ-RM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 00:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1j3Z5Z-00052B-S4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 00:37:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:32999)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1j3Z5Z-0004o7-DR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 00:37:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Feb 2020 21:36:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; 
 d="scan'208,217";a="268290094"
Received: from chenzh5-mobl2.ccr.corp.intel.com (HELO [10.249.194.146])
 ([10.249.194.146])
 by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2020 21:36:48 -0800
Subject: Re: The issues about architecture of the COLO checkpoint
To: Daniel Cho <danielcho@qnap.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
 <20200211174756.GA2798@work-vm> <8737854e2826400fa4d14dc408cfd947@huawei.com>
 <2b09c8650b944c908c0c95fefe6d759f@intel.com>
 <CA+XQNE5hn=FJh7cq5YP0ydYEHkap-a-9AXeTLJd=24sQ1DWkwg@mail.gmail.com>
 <1bf96353e8e2490098a71d0d1182986a@huawei.com>
 <51f95ec9ed4a4cc682e63abf1414979b@intel.com>
 <b440cfb28e6c4aa38d79b93ed04a106f@intel.com>
 <CA+XQNE78cE-wMtNZBrXa+HQmuXmRGtjKJr_0JXaYPCEFEhXgwQ@mail.gmail.com>
 <20200213103752.GE2960@work-vm>
 <CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com>
From: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <e820e35d-5b8a-18c8-736b-6c38cff9798e@intel.com>
Date: Mon, 17 Feb 2020 13:36:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------16048698033E6E567041C39F"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: Jason Wang <jasowang@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------16048698033E6E567041C39F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/15/2020 11:35 AM, Daniel Cho wrote:
> Hi Dave,
>
> Yes, I agree with you, it does need a timeout.


Hi Daniel and Dave,

Current colo-compare already have the timeout mechanism.

Named packet_check_timer,  It will scan primary packet queue to make 
sure all the primary packet not stay too long time.

If colo-compare got a primary packet without related secondary packet in 
a certain time , it will automatic trigger checkpoint.

https://github.com/qemu/qemu/blob/master/net/colo-compare.c#L847


Thanks

Zhang Chen


>
> Hi Hailiang,
>
> We base on qemu-4.1.0 for using COLO feature, in your patch, we found 
> a lot of difference  between your version and ours.
> Could you give us a latest release version which is close your 
> developing code?
>
> Thanks.
>
> Regards
> Daniel Cho
>
> Dr. David Alan Gilbert <dgilbert@redhat.com 
> <mailto:dgilbert@redhat.com>> 於 2020年2月13日 週四 下午6:38寫道：
>
>     * Daniel Cho (danielcho@qnap.com <mailto:danielcho@qnap.com>) wrote:
>     > Hi Hailiang,
>     >
>     > 1.
>     >     OK, we will try the patch
>     > “0001-COLO-Optimize-memory-back-up-process.patch”,
>     > and thanks for your help.
>     >
>     > 2.
>     >     We understand the reason to compare PVM and SVM's packet.
>     However, the
>     > empty of SVM's packet queue might happened on setting COLO
>     feature and SVM
>     > broken.
>     >
>     > On situation 1 ( setting COLO feature ):
>     >     We could force do checkpoint after setting COLO feature
>     finish, then it
>     > will protect the state of PVM and SVM . As the Zhang Chen said.
>     >
>     > On situation 2 ( SVM broken ):
>     >     COLO will do failover for PVM, so it might not cause any
>     wrong on PVM.
>     >
>     > However, those situations are our views, so there might be a big
>     difference
>     > between reality and our views.
>     > If we have any wrong views and opinions, please let us know, and
>     correct
>     > us.
>
>     It does need a timeout; the SVM being broken or being in a state where
>     it never sends the corresponding packet (because of a state
>     difference)
>     can happen and COLO needs to timeout when the packet hasn't arrived
>     after a while and trigger the checkpoint.
>
>     Dave
>
>     > Thanks.
>     >
>     > Best regards,
>     > Daniel Cho
>     >
>     > Zhang, Chen <chen.zhang@intel.com <mailto:chen.zhang@intel.com>>
>     於 2020年2月13日 週四 上午10:17寫道：
>     >
>     > > Add cc Jason Wang, he is a network expert.
>     > >
>     > > In case some network things goes wrong.
>     > >
>     > >
>     > >
>     > > Thanks
>     > >
>     > > Zhang Chen
>     > >
>     > >
>     > >
>     > > *From:* Zhang, Chen
>     > > *Sent:* Thursday, February 13, 2020 10:10 AM
>     > > *To:* 'Zhanghailiang' <zhang.zhanghailiang@huawei.com
>     <mailto:zhang.zhanghailiang@huawei.com>>; Daniel Cho <
>     > > danielcho@qnap.com <mailto:danielcho@qnap.com>>
>     > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com>>; qemu-devel@nongnu.org
>     <mailto:qemu-devel@nongnu.org>
>     > > *Subject:* RE: The issues about architecture of the COLO
>     checkpoint
>     > >
>     > >
>     > >
>     > > For the issue 2:
>     > >
>     > >
>     > >
>     > > COLO need use the network packets to confirm PVM and SVM in
>     the same state,
>     > >
>     > > Generally speaking, we can’t send PVM packets without compared
>     with SVM
>     > > packets.
>     > >
>     > > But to prevent jamming, I think COLO can do force checkpoint
>     and send the
>     > > PVM packets in this case.
>     > >
>     > >
>     > >
>     > > Thanks
>     > >
>     > > Zhang Chen
>     > >
>     > >
>     > >
>     > > *From:* Zhanghailiang <zhang.zhanghailiang@huawei.com
>     <mailto:zhang.zhanghailiang@huawei.com>>
>     > > *Sent:* Thursday, February 13, 2020 9:45 AM
>     > > *To:* Daniel Cho <danielcho@qnap.com <mailto:danielcho@qnap.com>>
>     > > *Cc:* Dr. David Alan Gilbert <dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com>>; qemu-devel@nongnu.org
>     <mailto:qemu-devel@nongnu.org>;
>     > > Zhang, Chen <chen.zhang@intel.com <mailto:chen.zhang@intel.com>>
>     > > *Subject:* RE: The issues about architecture of the COLO
>     checkpoint
>     > >
>     > >
>     > >
>     > > Hi,
>     > >
>     > >
>     > >
>     > > 1.       After re-walked through the codes, yes, you are
>     right, actually,
>     > > after the first migration, we will keep dirty log on in
>     primary side,
>     > >
>     > > And only send the dirty pages in PVM to SVM. The ram cache in
>     secondary
>     > > side is always a backup of PVM, so we don’t have to
>     > >
>     > > Re-send the none-dirtied pages.
>     > >
>     > > The reason why the first checkpoint takes longer time is we
>     have to backup
>     > > the whole VM’s ram into ram cache, that is colo_init_ram_cache().
>     > >
>     > > It is time consuming, but I have optimized in the second patch
>     > > “0001-COLO-Optimize-memory-back-up-process.patch” which you
>     can find in my
>     > > previous reply.
>     > >
>     > >
>     > >
>     > > Besides, I found that, In my previous reply “We can only copy
>     the pages
>     > > that dirtied by PVM and SVM in last checkpoint.”,
>     > >
>     > > We have done this optimization in current upstream codes.
>     > >
>     > >
>     > >
>     > > 2．I don’t quite understand this question. For COLO, we always
>     need both
>     > > network packets of PVM’s and SVM’s to compare before send this
>     packets to
>     > > client.
>     > >
>     > > It depends on this to decide whether or not PVM and SVM are in
>     same state.
>     > >
>     > >
>     > >
>     > > Thanks,
>     > >
>     > > hailiang
>     > >
>     > >
>     > >
>     > > *From:* Daniel Cho [mailto:danielcho@qnap.com
>     <mailto:danielcho@qnap.com> <danielcho@qnap.com
>     <mailto:danielcho@qnap.com>>]
>     > > *Sent:* Wednesday, February 12, 2020 4:37 PM
>     > > *To:* Zhang, Chen <chen.zhang@intel.com
>     <mailto:chen.zhang@intel.com>>
>     > > *Cc:* Zhanghailiang <zhang.zhanghailiang@huawei.com
>     <mailto:zhang.zhanghailiang@huawei.com>>; Dr. David Alan
>     > > Gilbert <dgilbert@redhat.com <mailto:dgilbert@redhat.com>>;
>     qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
>     > > *Subject:* Re: The issues about architecture of the COLO
>     checkpoint
>     > >
>     > >
>     > >
>     > > Hi Hailiang,
>     > >
>     > >
>     > >
>     > > Thanks for your replaying and explain in detail.
>     > >
>     > > We will try to use the attachments to enhance memory copy.
>     > >
>     > >
>     > >
>     > > However, we have some questions for your replying.
>     > >
>     > >
>     > >
>     > > 1.  As you said, "for each checkpoint, we have to send the
>     whole PVM's
>     > > pages To SVM", why the only first checkpoint will takes more
>     pause time?
>     > >
>     > > In our observing, the first checkpoint will take more time for
>     pausing,
>     > > then other checkpoints will takes a few time for pausing. Does
>     it means
>     > > only the first checkpoint will send the whole pages to SVM,
>     and the other
>     > > checkpoints send the dirty pages to SVM for reloading?
>     > >
>     > >
>     > >
>     > > 2. We notice the COLO-COMPARE component will stuck the packet
>     until
>     > > receive packets from PVM and SVM, as this rule, when we add the
>     > > COLO-COMPARE to PVM, its network will stuck until SVM start.
>     So it is an
>     > > other issue to make PVM stuck while setting COLO feature. With
>     this issue,
>     > > could we let colo-compare to pass the PVM's packet when the
>     SVM's packet
>     > > queue is empty? Then, the PVM's network won't stock, and "if
>     PVM runs
>     > > firstly, it still need to wait for The network packets from SVM to
>     > > compare before send it to client side" won't happened either.
>     > >
>     > >
>     > >
>     > > Best regard,
>     > >
>     > > Daniel Cho
>     > >
>     > >
>     > >
>     > > Zhang, Chen <chen.zhang@intel.com
>     <mailto:chen.zhang@intel.com>> 於 2020年2月12日 週三 下午1:45寫道：
>     > >
>     > >
>     > >
>     > > > -----Original Message-----
>     > > > From: Zhanghailiang <zhang.zhanghailiang@huawei.com
>     <mailto:zhang.zhanghailiang@huawei.com>>
>     > > > Sent: Wednesday, February 12, 2020 11:18 AM
>     > > > To: Dr. David Alan Gilbert <dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com>>; Daniel Cho
>     > > > <danielcho@qnap.com <mailto:danielcho@qnap.com>>; Zhang,
>     Chen <chen.zhang@intel.com <mailto:chen.zhang@intel.com>>
>     > > > Cc: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
>     > > > Subject: RE: The issues about architecture of the COLO
>     checkpoint
>     > > >
>     > > > Hi,
>     > > >
>     > > > Thank you Dave,
>     > > >
>     > > > I'll reply here directly.
>     > > >
>     > > > -----Original Message-----
>     > > > From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com>]
>     > > > Sent: Wednesday, February 12, 2020 1:48 AM
>     > > > To: Daniel Cho <danielcho@qnap.com
>     <mailto:danielcho@qnap.com>>; chen.zhang@intel.com
>     <mailto:chen.zhang@intel.com>;
>     > > > Zhanghailiang <zhang.zhanghailiang@huawei.com
>     <mailto:zhang.zhanghailiang@huawei.com>>
>     > > > Cc: qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>
>     > > > Subject: Re: The issues about architecture of the COLO
>     checkpoint
>     > > >
>     > > >
>     > > > cc'ing in COLO people:
>     > > >
>     > > >
>     > > > * Daniel Cho (danielcho@qnap.com
>     <mailto:danielcho@qnap.com>) wrote:
>     > > > > Hi everyone,
>     > > > >      We have some issues about setting COLO feature. Hope
>     somebody
>     > > > > could give us some advice.
>     > > > >
>     > > > > Issue 1:
>     > > > >      We dynamic to set COLO feature for PVM(2 core, 16G
>     memory),  but
>     > > > > the Primary VM will pause a long time(based on memory
>     size) for
>     > > > > waiting SVM start. Does it have any idea to reduce the
>     pause time?
>     > > > >
>     > > >
>     > > > Yes, we do have some ideas to optimize this downtime.
>     > > >
>     > > > The main problem for current version is, for each
>     checkpoint, we have to
>     > > > send the whole PVM's pages
>     > > > To SVM, and then copy the whole VM's state into SVM from ram
>     cache, in
>     > > > this process, we need both of them be paused.
>     > > > Just as you said, the downtime is based on memory size.
>     > > >
>     > > > So firstly, we need to reduce the sending data while do
>     checkpoint,
>     > > actually,
>     > > > we can migrate parts of PVM's dirty pages in background
>     > > > While both of VMs are running. And then we load these pages
>     into ram
>     > > > cache (backup memory) in SVM temporarily. While do checkpoint,
>     > > > We just send the last dirty pages of PVM to slave side and
>     then copy the
>     > > ram
>     > > > cache into SVM. Further on, we don't have
>     > > > To send the whole PVM's dirty pages, we can only send the
>     pages that
>     > > > dirtied by PVM or SVM during two checkpoints. (Because
>     > > > If one page is not dirtied by both PVM and SVM, the data of
>     this pages
>     > > will
>     > > > keep same in SVM, PVM, backup memory). This method can reduce
>     > > > the time that consumed in sending data.
>     > > >
>     > > > For the second problem, we can reduce the memory copy by two
>     methods,
>     > > > first one, we don't have to copy the whole pages in ram cache,
>     > > > We can only copy the pages that dirtied by PVM and SVM in last
>     > > checkpoint.
>     > > > Second, we can use userfault missing function to reduce the
>     > > > Time consumed in memory copy. (For the second time, in
>     theory, we can
>     > > > reduce time consumed in memory into ms level).
>     > > >
>     > > > You can find the first optimization in attachment, it is
>     based on an old
>     > > qemu
>     > > > version (qemu-2.6), it should not be difficult to rebase it
>     > > > Into master or your version. And please feel free to send
>     the new
>     > > version if
>     > > > you want into community ;)
>     > > >
>     > > >
>     > >
>     > > Thanks Hailiang!
>     > > By the way, Do you have time to push the patches to upstream?
>     > > I think this is a better and faster option.
>     > >
>     > > Thanks
>     > > Zhang Chen
>     > >
>     > > > >
>     > > > > Issue 2:
>     > > > >      In
>     > > > >
>     https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
>     > > > > could we move start_vm() before Line 488? Because at first
>     checkpoint
>     > > > > PVM will wait for SVM's reply, it cause PVM stop for a while.
>     > > > >
>     > > >
>     > > > No, that makes no sense, because if PVM runs firstly, it
>     still need to
>     > > wait for
>     > > > The network packets from SVM to compare before send it to
>     client side.
>     > > >
>     > > >
>     > > > Thanks,
>     > > > Hailiang
>     > > >
>     > > > >      We set the COLO feature on running VM, so we hope the
>     running VM
>     > > > > could continuous service for users.
>     > > > > Do you have any suggestions for those issues?
>     > > > >
>     > > > > Best regards,
>     > > > > Daniel Cho
>     > > > --
>     > > > Dr. David Alan Gilbert / dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com> / Manchester, UK
>     > >
>     > >
>     --
>     Dr. David Alan Gilbert / dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com> / Manchester, UK
>

--------------16048698033E6E567041C39F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/15/2020 11:35 AM, Daniel Cho
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>Hi Dave, </div>
        <div><br>
        </div>
        <div>Yes, I agree with you, it does need a timeout. <br>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Hi Daniel and Dave,</p>
    <p>Current colo-compare already have the timeout mechanism.</p>
    <p>Named packet_check_timer,  It will scan primary packet queue to
      make sure all the primary packet not stay too long time.</p>
    <p>If colo-compare got a primary packet without related secondary
      packet in a certain time , it will automatic trigger checkpoint.<br>
    </p>
    <p><a
        href="https://github.com/qemu/qemu/blob/master/net/colo-compare.c#L847">https://github.com/qemu/qemu/blob/master/net/colo-compare.c#L847</a></p>
    <p><br>
    </p>
    <p>Thanks</p>
    <p>Zhang Chen</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        Hi Hailiang, 
        <div><br>
        </div>
        <div>We base on qemu-4.1.0 for using COLO feature, in your
          patch, we found a lot of difference  between your version and
          ours.</div>
        <div>Could you give us a latest release version which is close
          your developing code?</div>
        <div><br>
        </div>
        <div>Thanks. </div>
        <div><br>
        </div>
        <div>Regards</div>
        <div>Daniel Cho</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">Dr. David Alan Gilbert &lt;<a
            href="mailto:dgilbert@redhat.com" moz-do-not-send="true">dgilbert@redhat.com</a>&gt;
          於 2020年2月13日 週四 下午6:38寫道：<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">*
          Daniel Cho (<a href="mailto:danielcho@qnap.com"
            target="_blank" moz-do-not-send="true">danielcho@qnap.com</a>)
          wrote:<br>
          &gt; Hi Hailiang,<br>
          &gt; <br>
          &gt; 1.<br>
          &gt;     OK, we will try the patch<br>
          &gt; “0001-COLO-Optimize-memory-back-up-process.patch”,<br>
          &gt; and thanks for your help.<br>
          &gt; <br>
          &gt; 2.<br>
          &gt;     We understand the reason to compare PVM and SVM's
          packet. However, the<br>
          &gt; empty of SVM's packet queue might happened on setting
          COLO feature and SVM<br>
          &gt; broken.<br>
          &gt; <br>
          &gt; On situation 1 ( setting COLO feature ):<br>
          &gt;     We could force do checkpoint after setting COLO
          feature finish, then it<br>
          &gt; will protect the state of PVM and SVM . As the Zhang Chen
          said.<br>
          &gt; <br>
          &gt; On situation 2 ( SVM broken ):<br>
          &gt;     COLO will do failover for PVM, so it might not cause
          any wrong on PVM.<br>
          &gt; <br>
          &gt; However, those situations are our views, so there might
          be a big difference<br>
          &gt; between reality and our views.<br>
          &gt; If we have any wrong views and opinions, please let us
          know, and correct<br>
          &gt; us.<br>
          <br>
          It does need a timeout; the SVM being broken or being in a
          state where<br>
          it never sends the corresponding packet (because of a state
          difference)<br>
          can happen and COLO needs to timeout when the packet hasn't
          arrived<br>
          after a while and trigger the checkpoint.<br>
          <br>
          Dave<br>
          <br>
          &gt; Thanks.<br>
          &gt; <br>
          &gt; Best regards,<br>
          &gt; Daniel Cho<br>
          &gt; <br>
          &gt; Zhang, Chen &lt;<a href="mailto:chen.zhang@intel.com"
            target="_blank" moz-do-not-send="true">chen.zhang@intel.com</a>&gt;
          於 2020年2月13日 週四 上午10:17寫道：<br>
          &gt; <br>
          &gt; &gt; Add cc Jason Wang, he is a network expert.<br>
          &gt; &gt;<br>
          &gt; &gt; In case some network things goes wrong.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks<br>
          &gt; &gt;<br>
          &gt; &gt; Zhang Chen<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; *From:* Zhang, Chen<br>
          &gt; &gt; *Sent:* Thursday, February 13, 2020 10:10 AM<br>
          &gt; &gt; *To:* 'Zhanghailiang' &lt;<a
            href="mailto:zhang.zhanghailiang@huawei.com" target="_blank"
            moz-do-not-send="true">zhang.zhanghailiang@huawei.com</a>&gt;;
          Daniel Cho &lt;<br>
          &gt; &gt; <a href="mailto:danielcho@qnap.com" target="_blank"
            moz-do-not-send="true">danielcho@qnap.com</a>&gt;<br>
          &gt; &gt; *Cc:* Dr. David Alan Gilbert &lt;<a
            href="mailto:dgilbert@redhat.com" target="_blank"
            moz-do-not-send="true">dgilbert@redhat.com</a>&gt;; <a
            href="mailto:qemu-devel@nongnu.org" target="_blank"
            moz-do-not-send="true">qemu-devel@nongnu.org</a><br>
          &gt; &gt; *Subject:* RE: The issues about architecture of the
          COLO checkpoint<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; For the issue 2:<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; COLO need use the network packets to confirm PVM and
          SVM in the same state,<br>
          &gt; &gt;<br>
          &gt; &gt; Generally speaking, we can’t send PVM packets
          without compared with SVM<br>
          &gt; &gt; packets.<br>
          &gt; &gt;<br>
          &gt; &gt; But to prevent jamming, I think COLO can do force
          checkpoint and send the<br>
          &gt; &gt; PVM packets in this case.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks<br>
          &gt; &gt;<br>
          &gt; &gt; Zhang Chen<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; *From:* Zhanghailiang &lt;<a
            href="mailto:zhang.zhanghailiang@huawei.com" target="_blank"
            moz-do-not-send="true">zhang.zhanghailiang@huawei.com</a>&gt;<br>
          &gt; &gt; *Sent:* Thursday, February 13, 2020 9:45 AM<br>
          &gt; &gt; *To:* Daniel Cho &lt;<a
            href="mailto:danielcho@qnap.com" target="_blank"
            moz-do-not-send="true">danielcho@qnap.com</a>&gt;<br>
          &gt; &gt; *Cc:* Dr. David Alan Gilbert &lt;<a
            href="mailto:dgilbert@redhat.com" target="_blank"
            moz-do-not-send="true">dgilbert@redhat.com</a>&gt;; <a
            href="mailto:qemu-devel@nongnu.org" target="_blank"
            moz-do-not-send="true">qemu-devel@nongnu.org</a>;<br>
          &gt; &gt; Zhang, Chen &lt;<a
            href="mailto:chen.zhang@intel.com" target="_blank"
            moz-do-not-send="true">chen.zhang@intel.com</a>&gt;<br>
          &gt; &gt; *Subject:* RE: The issues about architecture of the
          COLO checkpoint<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Hi,<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 1.       After re-walked through the codes, yes, you
          are right, actually,<br>
          &gt; &gt; after the first migration, we will keep dirty log on
          in primary side,<br>
          &gt; &gt;<br>
          &gt; &gt; And only send the dirty pages in PVM to SVM. The ram
          cache in secondary<br>
          &gt; &gt; side is always a backup of PVM, so we don’t have to<br>
          &gt; &gt;<br>
          &gt; &gt; Re-send the none-dirtied pages.<br>
          &gt; &gt;<br>
          &gt; &gt; The reason why the first checkpoint takes longer
          time is we have to backup<br>
          &gt; &gt; the whole VM’s ram into ram cache, that is
          colo_init_ram_cache().<br>
          &gt; &gt;<br>
          &gt; &gt; It is time consuming, but I have optimized in the
          second patch<br>
          &gt; &gt; “0001-COLO-Optimize-memory-back-up-process.patch”
          which you can find in my<br>
          &gt; &gt; previous reply.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Besides, I found that, In my previous reply “We can
          only copy the pages<br>
          &gt; &gt; that dirtied by PVM and SVM in last checkpoint.”,<br>
          &gt; &gt;<br>
          &gt; &gt; We have done this optimization in current upstream
          codes.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 2．I don’t quite understand this question. For COLO,
          we always need both<br>
          &gt; &gt; network packets of PVM’s and SVM’s to compare before
          send this packets to<br>
          &gt; &gt; client.<br>
          &gt; &gt;<br>
          &gt; &gt; It depends on this to decide whether or not PVM and
          SVM are in same state.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks,<br>
          &gt; &gt;<br>
          &gt; &gt; hailiang<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; *From:* Daniel Cho [mailto:<a
            href="mailto:danielcho@qnap.com" target="_blank"
            moz-do-not-send="true">danielcho@qnap.com</a> &lt;<a
            href="mailto:danielcho@qnap.com" target="_blank"
            moz-do-not-send="true">danielcho@qnap.com</a>&gt;]<br>
          &gt; &gt; *Sent:* Wednesday, February 12, 2020 4:37 PM<br>
          &gt; &gt; *To:* Zhang, Chen &lt;<a
            href="mailto:chen.zhang@intel.com" target="_blank"
            moz-do-not-send="true">chen.zhang@intel.com</a>&gt;<br>
          &gt; &gt; *Cc:* Zhanghailiang &lt;<a
            href="mailto:zhang.zhanghailiang@huawei.com" target="_blank"
            moz-do-not-send="true">zhang.zhanghailiang@huawei.com</a>&gt;;
          Dr. David Alan<br>
          &gt; &gt; Gilbert &lt;<a href="mailto:dgilbert@redhat.com"
            target="_blank" moz-do-not-send="true">dgilbert@redhat.com</a>&gt;;
          <a href="mailto:qemu-devel@nongnu.org" target="_blank"
            moz-do-not-send="true">qemu-devel@nongnu.org</a><br>
          &gt; &gt; *Subject:* Re: The issues about architecture of the
          COLO checkpoint<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Hi Hailiang,<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks for your replaying and explain in detail.<br>
          &gt; &gt;<br>
          &gt; &gt; We will try to use the attachments to enhance memory
          copy.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; However, we have some questions for your replying.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 1.  As you said, "for each checkpoint, we have to
          send the whole PVM's<br>
          &gt; &gt; pages To SVM", why the only first checkpoint will
          takes more pause time?<br>
          &gt; &gt;<br>
          &gt; &gt; In our observing, the first checkpoint will take
          more time for pausing,<br>
          &gt; &gt; then other checkpoints will takes a few time for
          pausing. Does it means<br>
          &gt; &gt; only the first checkpoint will send the whole pages
          to SVM, and the other<br>
          &gt; &gt; checkpoints send the dirty pages to SVM for
          reloading?<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; 2. We notice the COLO-COMPARE component will stuck
          the packet until<br>
          &gt; &gt; receive packets from PVM and SVM, as this rule, when
          we add the<br>
          &gt; &gt; COLO-COMPARE to PVM, its network will stuck until
          SVM start. So it is an<br>
          &gt; &gt; other issue to make PVM stuck while setting COLO
          feature. With this issue,<br>
          &gt; &gt; could we let colo-compare to pass the PVM's packet
          when the SVM's packet<br>
          &gt; &gt; queue is empty? Then, the PVM's network won't stock,
          and "if PVM runs<br>
          &gt; &gt; firstly, it still need to wait for The network
          packets from SVM to<br>
          &gt; &gt; compare before send it to client side" won't
          happened either.<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Best regard,<br>
          &gt; &gt;<br>
          &gt; &gt; Daniel Cho<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Zhang, Chen &lt;<a
            href="mailto:chen.zhang@intel.com" target="_blank"
            moz-do-not-send="true">chen.zhang@intel.com</a>&gt; 於
          2020年2月12日 週三 下午1:45寫道：<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; &gt; -----Original Message-----<br>
          &gt; &gt; &gt; From: Zhanghailiang &lt;<a
            href="mailto:zhang.zhanghailiang@huawei.com" target="_blank"
            moz-do-not-send="true">zhang.zhanghailiang@huawei.com</a>&gt;<br>
          &gt; &gt; &gt; Sent: Wednesday, February 12, 2020 11:18 AM<br>
          &gt; &gt; &gt; To: Dr. David Alan Gilbert &lt;<a
            href="mailto:dgilbert@redhat.com" target="_blank"
            moz-do-not-send="true">dgilbert@redhat.com</a>&gt;; Daniel
          Cho<br>
          &gt; &gt; &gt; &lt;<a href="mailto:danielcho@qnap.com"
            target="_blank" moz-do-not-send="true">danielcho@qnap.com</a>&gt;;
          Zhang, Chen &lt;<a href="mailto:chen.zhang@intel.com"
            target="_blank" moz-do-not-send="true">chen.zhang@intel.com</a>&gt;<br>
          &gt; &gt; &gt; Cc: <a href="mailto:qemu-devel@nongnu.org"
            target="_blank" moz-do-not-send="true">qemu-devel@nongnu.org</a><br>
          &gt; &gt; &gt; Subject: RE: The issues about architecture of
          the COLO checkpoint<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Hi,<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Thank you Dave,<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; I'll reply here directly.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; -----Original Message-----<br>
          &gt; &gt; &gt; From: Dr. David Alan Gilbert [mailto:<a
            href="mailto:dgilbert@redhat.com" target="_blank"
            moz-do-not-send="true">dgilbert@redhat.com</a>]<br>
          &gt; &gt; &gt; Sent: Wednesday, February 12, 2020 1:48 AM<br>
          &gt; &gt; &gt; To: Daniel Cho &lt;<a
            href="mailto:danielcho@qnap.com" target="_blank"
            moz-do-not-send="true">danielcho@qnap.com</a>&gt;; <a
            href="mailto:chen.zhang@intel.com" target="_blank"
            moz-do-not-send="true">chen.zhang@intel.com</a>;<br>
          &gt; &gt; &gt; Zhanghailiang &lt;<a
            href="mailto:zhang.zhanghailiang@huawei.com" target="_blank"
            moz-do-not-send="true">zhang.zhanghailiang@huawei.com</a>&gt;<br>
          &gt; &gt; &gt; Cc: <a href="mailto:qemu-devel@nongnu.org"
            target="_blank" moz-do-not-send="true">qemu-devel@nongnu.org</a><br>
          &gt; &gt; &gt; Subject: Re: The issues about architecture of
          the COLO checkpoint<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; cc'ing in COLO people:<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; * Daniel Cho (<a
            href="mailto:danielcho@qnap.com" target="_blank"
            moz-do-not-send="true">danielcho@qnap.com</a>) wrote:<br>
          &gt; &gt; &gt; &gt; Hi everyone,<br>
          &gt; &gt; &gt; &gt;      We have some issues about setting
          COLO feature. Hope somebody<br>
          &gt; &gt; &gt; &gt; could give us some advice.<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt; Issue 1:<br>
          &gt; &gt; &gt; &gt;      We dynamic to set COLO feature for
          PVM(2 core, 16G memory),  but<br>
          &gt; &gt; &gt; &gt; the Primary VM will pause a long
          time(based on memory size) for<br>
          &gt; &gt; &gt; &gt; waiting SVM start. Does it have any idea
          to reduce the pause time?<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Yes, we do have some ideas to optimize this
          downtime.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; The main problem for current version is, for
          each checkpoint, we have to<br>
          &gt; &gt; &gt; send the whole PVM's pages<br>
          &gt; &gt; &gt; To SVM, and then copy the whole VM's state into
          SVM from ram cache, in<br>
          &gt; &gt; &gt; this process, we need both of them be paused.<br>
          &gt; &gt; &gt; Just as you said, the downtime is based on
          memory size.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; So firstly, we need to reduce the sending data
          while do checkpoint,<br>
          &gt; &gt; actually,<br>
          &gt; &gt; &gt; we can migrate parts of PVM's dirty pages in
          background<br>
          &gt; &gt; &gt; While both of VMs are running. And then we load
          these pages into ram<br>
          &gt; &gt; &gt; cache (backup memory) in SVM temporarily. While
          do checkpoint,<br>
          &gt; &gt; &gt; We just send the last dirty pages of PVM to
          slave side and then copy the<br>
          &gt; &gt; ram<br>
          &gt; &gt; &gt; cache into SVM. Further on, we don't have<br>
          &gt; &gt; &gt; To send the whole PVM's dirty pages, we can
          only send the pages that<br>
          &gt; &gt; &gt; dirtied by PVM or SVM during two checkpoints.
          (Because<br>
          &gt; &gt; &gt; If one page is not dirtied by both PVM and SVM,
          the data of this pages<br>
          &gt; &gt; will<br>
          &gt; &gt; &gt; keep same in SVM, PVM, backup memory). This
          method can reduce<br>
          &gt; &gt; &gt; the time that consumed in sending data.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; For the second problem, we can reduce the
          memory copy by two methods,<br>
          &gt; &gt; &gt; first one, we don't have to copy the whole
          pages in ram cache,<br>
          &gt; &gt; &gt; We can only copy the pages that dirtied by PVM
          and SVM in last<br>
          &gt; &gt; checkpoint.<br>
          &gt; &gt; &gt; Second, we can use userfault missing function
          to reduce the<br>
          &gt; &gt; &gt; Time consumed in memory copy. (For the second
          time, in theory, we can<br>
          &gt; &gt; &gt; reduce time consumed in memory into ms level).<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; You can find the first optimization in
          attachment, it is based on an old<br>
          &gt; &gt; qemu<br>
          &gt; &gt; &gt; version (qemu-2.6), it should not be difficult
          to rebase it<br>
          &gt; &gt; &gt; Into master or your version. And please feel
          free to send the new<br>
          &gt; &gt; version if<br>
          &gt; &gt; &gt; you want into community ;)<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks Hailiang!<br>
          &gt; &gt; By the way, Do you have time to push the patches to
          upstream?<br>
          &gt; &gt; I think this is a better and faster option.<br>
          &gt; &gt;<br>
          &gt; &gt; Thanks<br>
          &gt; &gt; Zhang Chen<br>
          &gt; &gt;<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt; Issue 2:<br>
          &gt; &gt; &gt; &gt;      In<br>
          &gt; &gt; &gt; &gt; <a
            href="https://github.com/qemu/qemu/blob/master/migration/colo.c#L503"
            rel="noreferrer" target="_blank" moz-do-not-send="true">https://github.com/qemu/qemu/blob/master/migration/colo.c#L503</a>,<br>
          &gt; &gt; &gt; &gt; could we move start_vm() before Line 488?
          Because at first checkpoint<br>
          &gt; &gt; &gt; &gt; PVM will wait for SVM's reply, it cause
          PVM stop for a while.<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; No, that makes no sense, because if PVM runs
          firstly, it still need to<br>
          &gt; &gt; wait for<br>
          &gt; &gt; &gt; The network packets from SVM to compare before
          send it to client side.<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; Thanks,<br>
          &gt; &gt; &gt; Hailiang<br>
          &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt;      We set the COLO feature on running
          VM, so we hope the running VM<br>
          &gt; &gt; &gt; &gt; could continuous service for users.<br>
          &gt; &gt; &gt; &gt; Do you have any suggestions for those
          issues?<br>
          &gt; &gt; &gt; &gt;<br>
          &gt; &gt; &gt; &gt; Best regards,<br>
          &gt; &gt; &gt; &gt; Daniel Cho<br>
          &gt; &gt; &gt; --<br>
          &gt; &gt; &gt; Dr. David Alan Gilbert / <a
            href="mailto:dgilbert@redhat.com" target="_blank"
            moz-do-not-send="true">dgilbert@redhat.com</a> / Manchester,
          UK<br>
          &gt; &gt;<br>
          &gt; &gt;<br>
          --<br>
          Dr. David Alan Gilbert / <a href="mailto:dgilbert@redhat.com"
            target="_blank" moz-do-not-send="true">dgilbert@redhat.com</a>
          / Manchester, UK<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------16048698033E6E567041C39F--

