Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811DEC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4784C208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r8TDMXog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4784C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjbH-0004vR-Fy
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jBjaX-00048V-Fh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jBjaV-00011n-Pg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:26:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jBjaV-0000wd-ET
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:26:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AIOd6s191498;
 Tue, 10 Mar 2020 18:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8s9ow+tMldhZCbTq5hAdX4GXcmxMtO9dagFa+1rOaYY=;
 b=r8TDMXogblrFWmJZ8d9b65y+eHcrKgiAtDIYSgKyD9fOQA9ZLG84wYxaCzG7SMs/SAk7
 EhC/0PsSJAdPZQsgsITZIWe/pHf+1hX74l5a8J+JDJV/TB5nTyAYiPAh11szWdk/jBoQ
 t6RZbjr7h6Jw21Oe6YSNJpGfi7nIgJg+CgL7PV92jS99xdj2s1j/ttta3ttoj81DKoHw
 ZYViPcM6Y7zxr+fLaBIE3CeYgv3ExXwRODK2YWTG+gufDB9FasQCtkb317Yl+ken99q7
 uzWS2JJ83KaiV/sIy1m5qOwM15YakZBxQ1JmWqT9qoue++rR7/9e1G53TrB32ICZgyAE LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2ym31ufb22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 18:26:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AIM8xR029203;
 Tue, 10 Mar 2020 18:26:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yp8pt3gum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 18:26:30 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AIQSQx005220;
 Tue, 10 Mar 2020 18:26:28 GMT
Received: from flaka (/174.207.15.0) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 11:26:28 -0700
Date: Tue, 10 Mar 2020 11:26:23 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v5 07/50] multi-process: define mpqemu-link object
Message-ID: <20200310182623.GA6543@flaka>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <20ec6f6666cc8adb211642156f5230e478143b81.1582576372.git.jag.raman@oracle.com>
 <20200310160941.GK140737@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310160941.GK140737@stefanha-x1.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, liran.alon@oracle.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 04:09:41PM +0000, Stefan Hajnoczi wrote:
> On Mon, Feb 24, 2020 at 03:54:58PM -0500, Jagannathan Raman wrote:
> > +/*
> > + * TODO: Dont use mpqemu link object since it is
> > + * not needed to be created via -object.
> > + */
> 
> Please investigate and resolve this TODO.
>
Thank you Stefan for reviewing more patches.
This particular TODO have to be removed and I am guessing
followed us from the earlier code.
 
> > +struct conf_data_msg {
> > +    uint32_t addr;
> > +    uint32_t val;
> > +    int l;
> 
> Please use a self-explanatory field name.  I'm not sure what 'l' is.
> 
> conf_data_msg is not used in this patch.  Please introduce things when
> they are needed to make the patch series easier to review in a linear
> fashion.

Will do.
> 
> > +/*
> > + * TODO: make all communications asynchronous and run in the main
> > + * loop or existing IOThread.
> > + */
> 
> Please investigate and decide how to resolve this TODO.
> 
> > +void mpqemu_msg_send(MPQemuMsg *msg, MPQemuChannel *chan)
> > +{
> > +    int rc;
> > +    uint8_t *data;
> > +    union {
> > +        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
> > +        struct cmsghdr align;
> > +    } u;
> > +    struct msghdr hdr;
> > +    struct cmsghdr *chdr;
> > +    int sock = chan->sock;
> > +    QemuMutex *lock = &chan->send_lock;
> > +
> > +    struct iovec iov = {
> > +        .iov_base = (char *) msg,
> > +        .iov_len = MPQEMU_MSG_HDR_SIZE,
> > +    };
> > +
> > +    memset(&hdr, 0, sizeof(hdr));
> > +    memset(&u, 0, sizeof(u));
> > +
> > +    hdr.msg_iov = &iov;
> > +    hdr.msg_iovlen = 1;
> > +
> > +    if (msg->num_fds > REMOTE_MAX_FDS) {
> > +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
> > +        return;
> > +    }
> > +
> > +    if (msg->num_fds > 0) {
> > +        size_t fdsize = msg->num_fds * sizeof(int);
> > +
> > +        hdr.msg_control = &u;
> > +        hdr.msg_controllen = sizeof(u);
> > +
> > +        chdr = CMSG_FIRSTHDR(&hdr);
> > +        chdr->cmsg_len = CMSG_LEN(fdsize);
> > +        chdr->cmsg_level = SOL_SOCKET;
> > +        chdr->cmsg_type = SCM_RIGHTS;
> > +        memcpy(CMSG_DATA(chdr), msg->fds, fdsize);
> > +        hdr.msg_controllen = CMSG_SPACE(fdsize);
> > +    }
> > +
> > +    qemu_mutex_lock(lock);
> > +
> > +    do {
> > +        rc = sendmsg(sock, &hdr, 0);
> > +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> > +
> > +    if (rc < 0) {
> > +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, errno is %d,"
> > +                      " sock %d\n", __func__, rc, errno, sock);
> > +        qemu_mutex_unlock(lock);
> > +        return;
> > +    }
> > +
> > +    if (msg->bytestream) {
> > +        data = msg->data2;
> > +    } else {
> > +        data = (uint8_t *)msg + MPQEMU_MSG_HDR_SIZE;
> > +    }
> > +
> > +    do {
> > +        rc = write(sock, data, msg->size);
> > +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> > +
> > +    qemu_mutex_unlock(lock);
> 
> Can this lock be avoided by using a single sendmsg(2) syscall instead of
> sendmsg() + write()?  I feel deja vu here, like I maybe have raised this
> in a previous revision of this patch series.
> 

Indeed, you did mention this. Sorry, it got forgotten.
It seems to be possible, we will investigate further and include in the
next version.

> > +    msg->num_fds = 0;
> > +    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
> > +         chdr = CMSG_NXTHDR(&hdr, chdr)) {
> > +        if ((chdr->cmsg_level == SOL_SOCKET) &&
> > +            (chdr->cmsg_type == SCM_RIGHTS)) {
> > +            fdsize = chdr->cmsg_len - CMSG_LEN(0);
> > +            msg->num_fds = fdsize / sizeof(int);
> > +            if (msg->num_fds > REMOTE_MAX_FDS) {
> > +                /*
> > +                 * TODO: Security issue detected. Sender never sends more
> > +                 * than REMOTE_MAX_FDS. This condition should be signaled to
> > +                 * the admin
> > +                 */
> 
> This TODO doesn't seem actionable.  The error is already handled.
> 
> > +                qemu_log_mask(LOG_REMOTE_DEBUG,
> > +                              "%s: Max FDs exceeded\n", __func__);
> > +                return -ERANGE;
> 
> The mutex must be released.

Thank you! Will fix this and above.


Elena

