Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD76C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18E22053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18E22053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwqC-0003Yp-Rf
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:56:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwpS-0003Fk-DX
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwpR-0008Ha-3s
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:56:06 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:34923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNwpQ-0008Ff-UL
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:56:05 -0400
Received: from player773.ha.ovh.net (unknown [10.108.42.167])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 574DB22E55C
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 11:56:02 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player773.ha.ovh.net (Postfix) with ESMTPSA id B2A6A57D3893;
	Tue,  7 May 2019 09:55:57 +0000 (UTC)
Date: Tue, 7 May 2019 11:55:56 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190507115556.3d578690@bahia.lan>
In-Reply-To: <1895198.u98Sn5qOsY@silver>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<1895198.u98Sn5qOsY@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6211026838202849600
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkedtgddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.116.78
Subject: Re: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
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
Cc: qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06 May 2019 19:58:28 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This is the counter part patch against latest libvirt git master head to

Hmm... shouldn't this be Cc'd to libvir-list@redhat.com as well then ?

> support the 'vii' feature of patch 5, which introduces the XML config

What is patch 5 ?!? What is 'vii' ? I am a bit lost here...

> XML tag "important" on libvirt side.
> 
> To stick with the previous example mentioned with patch 5, likewise
> libvirt XML configuration might then look like this:
> 
>   <domain type='kvm'>
>     ...
>     <devices>
>       ...
>       <filesystem type='mount' accessmode='mapped'>
>         <source dir='/vm/fs'/>
>         <target dir='root'/>
>         <important path='/var/shares'/>
>         <important path='/tmp'/>
>       </filesystem>
>     </devices>
>   </domain>
> 
> Like with the vii qemu virtfs command line argument, the order of the
> "important" tag defines which one gets the highest inode namespace
> (smallest generated suffix) on guest side.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  docs/schemas/domaincommon.rng |  6 ++++++
>  src/conf/domain_conf.c        | 30 ++++++++++++++++++++++++++++++
>  src/conf/domain_conf.h        |  3 +++
>  src/qemu/qemu_command.c       | 10 ++++++++++
>  4 files changed, 49 insertions(+)
> 
> diff --git a/docs/schemas/domaincommon.rng b/docs/schemas/domaincommon.rng
> index 111b85c36f..c75edfc4d3 100644
> --- a/docs/schemas/domaincommon.rng
> +++ b/docs/schemas/domaincommon.rng
> @@ -2515,6 +2515,12 @@
>              </choice>
>            </attribute>
>          </optional>
> +        <zeroOrMore>
> +          <element name='important'>
> +            <attribute name="path"/>
> +            <empty/>
> +          </element>
> +        </zeroOrMore>
>          <optional>
>            <element name='readonly'>
>              <empty/>
> diff --git a/src/conf/domain_conf.c b/src/conf/domain_conf.c
> index b4fb6cf981..cc75c6a7dd 100644
> --- a/src/conf/domain_conf.c
> +++ b/src/conf/domain_conf.c
> @@ -2294,6 +2294,8 @@ virDomainFSDefNew(void)
>  
>  void virDomainFSDefFree(virDomainFSDefPtr def)
>  {
> +    size_t i;
> +
>      if (!def)
>          return;
>  
> @@ -2302,6 +2304,13 @@ void virDomainFSDefFree(virDomainFSDefPtr def)
>      virDomainDeviceInfoClear(&def->info);
>      VIR_FREE(def->virtio);
>  
> +    if (def->important) {
> +        for (i = 0; i < def->nimportant; i++)
> +            if (def->important[i])
> +                VIR_FREE(def->important[i]);
> +    }
> +    VIR_FREE(def->important);
> +
>      VIR_FREE(def);
>  }
>  
> @@ -10953,6 +10962,7 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
>      VIR_AUTOFREE(char *) usage = NULL;
>      VIR_AUTOFREE(char *) units = NULL;
>      VIR_AUTOFREE(char *) model = NULL;
> +    long n;
>  
>      ctxt->node = node;
>  
> @@ -11001,6 +11011,12 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
>                                    1, ULLONG_MAX, false) < 0)
>          goto error;
>  
> +    n = virXMLChildElementCount(node);
> +    if (n > 0) {
> +        if (VIR_ALLOC_N(def->important, n) < 0)
> +            goto error;
> +    }
> +
>      cur = node->children;
>      while (cur != NULL) {
>          if (cur->type == XML_ELEMENT_NODE) {
> @@ -11039,6 +11055,8 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
>  
>                  if (virDomainVirtioOptionsParseXML(cur, &def->virtio) < 0)
>                      goto error;
> +            } else if (virXMLNodeNameEqual(cur, "important")) {
> +                def->important[def->nimportant++] = virXMLPropString(cur, "path");
>              }
>          }
>          cur = cur->next;
> @@ -11107,6 +11125,8 @@ virDomainFSDefParseXML(virDomainXMLOptionPtr xmlopt,
>          goto error;
>  
>   cleanup:
> +    if (def && def->important && !def->nimportant)
> +        VIR_FREE(def->important);
>      return def;
>  
>   error:
> @@ -24601,6 +24621,7 @@ virDomainFSDefFormat(virBufferPtr buf,
>      const char *src = def->src->path;
>      VIR_AUTOCLEAN(virBuffer) driverBuf = VIR_BUFFER_INITIALIZER;
>      int ret = -1;
> +    size_t i;
>  
>      if (!type) {
>          virReportError(VIR_ERR_INTERNAL_ERROR,
> @@ -24689,6 +24710,15 @@ virDomainFSDefFormat(virBufferPtr buf,
>      if (def->readonly)
>          virBufferAddLit(buf, "<readonly/>\n");
>  
> +    if (def->important) {
> +        for (i = 0; i < def->nimportant; ++i) {
> +            if (!def->important[i]) continue;
> +            virBufferAddLit(buf, "<important");
> +            virBufferEscapeString(buf, " path='%s'", def->important[i]);
> +            virBufferAddLit(buf, "/>\n");
> +        }
> +    }
> +
>      if (virDomainDeviceInfoFormat(buf, &def->info, flags) < 0)
>          goto cleanup;
>  
> diff --git a/src/conf/domain_conf.h b/src/conf/domain_conf.h
> index 01c22d8cc3..9bbd66d932 100644
> --- a/src/conf/domain_conf.h
> +++ b/src/conf/domain_conf.h
> @@ -818,6 +818,9 @@ struct _virDomainFSDef {
>      unsigned long long space_soft_limit; /* in bytes */
>      bool symlinksResolved;
>      virDomainVirtioOptionsPtr virtio;
> +
> +    size_t nimportant;
> +    char **important;
>  };
>  
>  
> diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
> index 50b4205267..2005ccadf8 100644
> --- a/src/qemu/qemu_command.c
> +++ b/src/qemu/qemu_command.c
> @@ -2732,6 +2732,7 @@ qemuBuildFSStr(virDomainFSDefPtr fs)
>      virBuffer opt = VIR_BUFFER_INITIALIZER;
>      const char *driver = qemuDomainFSDriverTypeToString(fs->fsdriver);
>      const char *wrpolicy = virDomainFSWrpolicyTypeToString(fs->wrpolicy);
> +    size_t i;
>  
>      if (fs->type != VIR_DOMAIN_FS_TYPE_MOUNT) {
>          virReportError(VIR_ERR_CONFIG_UNSUPPORTED, "%s",
> @@ -2775,6 +2776,15 @@ qemuBuildFSStr(virDomainFSDefPtr fs)
>      if (fs->readonly)
>          virBufferAddLit(&opt, ",readonly");
>  
> +    if (fs->important) {
> +        for (i = 0; i < fs->nimportant; ++i) {
> +            if (i == 0)
> +                virBufferAsprintf(&opt, ",vii=%s", fs->important[i]);
> +            else
> +                virBufferAsprintf(&opt, ":%s", fs->important[i]);
> +        }
> +    }
> +
>      if (virBufferCheckError(&opt) < 0)
>          goto error;
>  


