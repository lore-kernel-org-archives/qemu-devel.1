Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC275C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AF320674
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="p3nBNR/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AF320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7d2V-0006nB-S6
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7d1j-0006He-Bi
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:10:07 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37958 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7d1g-0005Op-RH
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:10:07 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id CEA19527EA;
 Mon, 17 Aug 2020 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1597662601;
 x=1599477002; bh=KLc2hLS6NvLy5bg6ka9HQt9T0e5D2+jdsNX1eMkQKtc=; b=
 p3nBNR/qmW5rWh2q4xjC+WfwbbzYvNV4vEfuQn7wTmbQ5Dx5mVogbo5/87gxGtZA
 +G1SxR0PHAL7zM1oSsH9tt5jP4g4D65y0N0Gt4Z+mfpuXGUmJ/bn1n8JYAxp18by
 8OuJfTjTVKcOx3aYViY9Sb4Da9ZXD624xIg9CSmSf7I=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XRvaMNN-Pj88; Mon, 17 Aug 2020 14:10:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 4D8805274C;
 Mon, 17 Aug 2020 14:10:01 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 17
 Aug 2020 14:10:01 +0300
Date: Mon, 17 Aug 2020 14:10:00 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 025/150] libqemuutil, qapi, trace: convert to meson
Message-ID: <20200817111000.GB98227@SPB-NB-133.local>
References: <20200814091326.16173-1-pbonzini@redhat.com>
 <20200814091326.16173-26-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200814091326.16173-26-pbonzini@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 07:02:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 05:11:21AM -0400, Paolo Bonzini wrote:
> This shows how to do some "computations" in meson.build using its array
> and dictionary data structures, and also a basic usage of the sourceset
> module for conditional compilation.
> 
> [...]
> diff --git a/trace/meson.build b/trace/meson.build
> new file mode 100644
> index 0000000000..f0a8d1c2e2
> --- /dev/null
> +++ b/trace/meson.build
> @@ -0,0 +1,76 @@
> +trace_events_files = []
> +foreach dir : [ '.' ] + trace_events_subdirs
> +  trace_events_file = meson.source_root() / dir / 'trace-events'
> +  trace_events_files += [ trace_events_file ]
> +  group_name = dir == '.' ? 'root' : dir.underscorify()
> +  group = '--group=' + group_name
> +  fmt = '@0@-' + group_name + '.@1@'
> +
> +  trace_h = custom_target(fmt.format('trace', 'h'),
> +                          output: fmt.format('trace', 'h'),
> +                          input: trace_events_file,
> +                          command: [ tracetool, group, '--format=h', '@INPUT@' ],
> +                          capture: true)
> +  genh += trace_h
> +  trace_c = custom_target(fmt.format('trace', 'c'),
> +                          output: fmt.format('trace', 'c'),
> +                          input: trace_events_file,
> +                          command: [ tracetool, group, '--format=c', '@INPUT@' ],
> +                          capture: true)
> +  if 'CONFIG_TRACE_UST' in config_host
> +    trace_ust_h = custom_target(fmt.format('trace-ust', 'h'),
> +                                output: fmt.format('trace-ust', 'h'),
> +                                input: trace_events_file,
> +                                command: [ tracetool, group, '--format=ust-events-h', '@INPUT@' ],
> +                                capture: true)
> +    trace_ss.add(trace_ust_h, lttng, urcubp)
> +    genh += trace_ust_h
> +  endif
> +  trace_ss.add(trace_h, trace_c)
> +  if 'CONFIG_TRACE_DTRACE' in config_host
> +    trace_dtrace = custom_target(fmt.format('trace-dtrace', 'dtrace'),
> +                                 output: fmt.format('trace-dtrace', 'dtrace'),
> +                                 input: trace_events_file,
> +                                 command: [ tracetool, group, '--format=d', '@INPUT@' ],
> +                                 capture: true)
> +    trace_dtrace_h = custom_target(fmt.format('trace-dtrace', 'h'),
> +                                   output: fmt.format('trace-dtrace', 'h'),
> +                                   input: trace_dtrace,
> +                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-h', '-s', '@INPUT@' ])
> +    trace_dtrace_o = custom_target(fmt.format('trace-dtrace', 'o'),
> +                                   output: fmt.format('trace-dtrace', 'o'),
> +                                   input: trace_dtrace,
> +                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-G', '-s', '@INPUT@' ])
> +
> +    trace_ss.add(trace_dtrace_h, trace_dtrace_o)

The patch conflicts with the latest tracing PULL request, object files
shouldn't be generated on darwin:

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02493.html

Thanks,
Roman

> +    genh += trace_dtrace_h
> +  endif
> +endforeach
> +
> +custom_target('trace-events-all',
> +              output: 'trace-events-all',
> +              input: trace_events_files,
> +              command: [ 'cat', '@INPUT@' ],
> +              capture: true,
> +              install: true,
> +              install_dir: config_host['qemu_datadir'])
> +
> +if 'CONFIG_TRACE_UST' in config_host
> +  trace_ust_all_h = custom_target('trace-ust-all.h',
> +                                  output: 'trace-ust-all.h',
> +                                  input: trace_events_files,
> +                                  command: [ tracetool, '--group=all', '--format=ust-events-h', '@INPUT@' ],
> +                                  capture: true)
> +  trace_ust_all_c = custom_target('trace-ust-all.c',
> +                                  output: 'trace-ust-all.c',
> +                                  input: trace_events_files,
> +                                  command: [ tracetool, '--group=all', '--format=ust-events-c', '@INPUT@' ],
> +                                  capture: true)
> +  trace_ss.add(trace_ust_all_h, trace_ust_all_c)
> +  genh += trace_ust_all_h
> +endif
> +
> +trace_ss.add(when: 'CONFIG_TRACE_SIMPLE', if_true: files('simple.c'))
> +trace_ss.add(when: 'CONFIG_TRACE_FTRACE', if_true: files('ftrace.c'))
> +trace_ss.add(files('control.c'))
> +trace_ss.add(files('qmp.c'))

