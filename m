Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B37D20663
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B37D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3rY-0006HN-3j
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3bF-0005EI-6w
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:47:22 -0400
Received: from relay68.bu.edu ([128.197.228.73]:38891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kT3bC-0001UV-Ot
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:47:20 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 09FDkJpb003517
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Oct 2020 09:46:22 -0400
Date: Thu, 15 Oct 2020 09:46:19 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 11/16] scripts/oss-fuzz: Add general-fuzzer build script
Message-ID: <20201015134619.la7nndj7hqkeh5kn@mozz.bu.edu>
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-12-alxndr@bu.edu>
 <cfe27655-7f00-9b5f-96b7-a8dcbf12d05e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe27655-7f00-9b5f-96b7-a8dcbf12d05e@redhat.com>
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 09:44:03
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201008 0935, Paolo Bonzini wrote:
> On 21/09/20 04:25, Alexander Bulekov wrote:
> > This parses a yaml file containing general-fuzzer configs and builds a
> > separate oss-fuzz wrapper binary for each one, changing some
> > preprocessor macros for each configuration. To avoid dealing with
> > escaping and stringifying, convert each string into a byte-array
> > representation
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  scripts/oss-fuzz/build_general_fuzzers.py | 69 +++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100755 scripts/oss-fuzz/build_general_fuzzers.py
> > 
> > diff --git a/scripts/oss-fuzz/build_general_fuzzers.py b/scripts/oss-fuzz/build_general_fuzzers.py
> > new file mode 100755
> > index 0000000000..918f1143a5
> > --- /dev/null
> > +++ b/scripts/oss-fuzz/build_general_fuzzers.py
> > @@ -0,0 +1,69 @@
> > +#!/usr/bin/env python3
> > +# -*- coding: utf-8 -*-
> > +
> > +"""
> > +This script creates wrapper binaries that invoke the general-device-fuzzer with
> > +configurations specified in a yaml config file.
> > +"""
> > +import sys
> > +import os
> > +import yaml
> > +import tempfile
> > +
> > +CC = ""
> > +TEMPLATE_FILENAME = "target_template.c"
> > +TEMPLATE_PATH = ""
> > +
> > +
> > +def usage():
> > +    print("Usage: CC=COMPILER {} CONFIG_PATH \
> > +OUTPUT_PATH_PREFIX".format(sys.argv[0]))
> > +    sys.exit(0)
> > +
> > +
> > +def str_to_c_byte_array(s):
> > +    """
> > +    Convert strings to byte-arrays so we don't worry about formatting
> > +    strings to play nicely with cc -DQEMU_FUZZARGS etc
> > +    """
> > +    return ','.join('0x{:02x}'.format(ord(x)) for x in s)
> > +
> > +
> > +def compile_wrapper(cfg, path):
> > +    os.system('$CC -DQEMU_FUZZ_ARGS="{fuzz_args}" \
> > +               -DQEMU_FUZZ_OBJECTS="{fuzz_objs}" \
> > +               {wrapper_template} -o {output_bin}'.format(
> > +                   fuzz_args=str_to_c_byte_array(cfg["args"].replace("\n", " ")),
> > +                   fuzz_objs=str_to_c_byte_array(cfg["objects"].replace("\n", " ")),
> > +                   wrapper_template=TEMPLATE_PATH,
> > +                   output_bin=path))
> > +
> > +
> > +def main():
> > +    global CC
> > +    global TEMPLATE_PATH
> > +    global OUTPUT_BIN_NAME
> > +
> > +    if len(sys.argv) != 3:
> > +        usage()
> > +
> > +    cfg_path = sys.argv[1]
> > +    out_path = sys.argv[2]
> > +
> > +    CC = os.getenv("CC", default="cc")
> > +    TEMPLATE_PATH = os.path.join(os.path.dirname(__file__), TEMPLATE_FILENAME)
> > +    if not os.path.exists(TEMPLATE_PATH):
> > +        print("Error {} doesn't exist".format(TEMPLATE_PATH))
> > +        sys.exit(1)
> > +
> > +    with open(cfg_path, "r") as f:
> > +        configs = yaml.load(f)["configs"]
> > +    for cfg in configs:
> > +        assert "name" in cfg
> > +        assert "args" in cfg
> > +        assert "objects" in cfg
> > +        compile_wrapper(cfg, out_path + cfg["name"])
> > +
> > +
> > +if __name__ == '__main__':
> > +    main()
> > 
> 
> Can you instead write an array of
> 
> struct {
>     const char *name, *args, *objects;
> }
> 
> and use it in the normal argv0-based selection?  The advantage would be
> that you can do the whole build within tests/qtest/fuzz/meson.build
> instead of having yet another undocumented shell script (cue all the
> mess I made when trying to modify scripts/oss-fuzz/build.sh).
> 
> Paolo

Thanks for the suggestion. I did this in v4, and I think it is much
nicer. No more python script, c template, and preprocessor hacking. I
don't think the way I defined the configs is ideal, however I think it
is already a better solution.
-Alex

> 

