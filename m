Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA89C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4C02145D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7EVb2AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4C02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLFwx-00046n-Ma
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLFwM-0003cO-E5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLFwJ-0005OL-If
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600910449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4Q2bQwITOt4CnUmbOEijIKs9JbXmJrWUMOQYFurOPI=;
 b=D7EVb2ALnpKCI1pEPw/qpEr6rQLEUQfKxbYbrxVtyt9omHbCVKvuSO2Ka9AZRLd0uhNIB4
 pSUgSJSOuoxWjG2TLwNghNf5DDLBQ+rc41vbzHA6LrNSaUoQHVXJNIhNRWtng5+PRWHwaR
 AQOgpuxAm7vX/ghYn+CSEizd+oQt+qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-M9AHGrnEPiqbaT0czWmIJw-1; Wed, 23 Sep 2020 21:20:43 -0400
X-MC-Unique: M9AHGrnEPiqbaT0czWmIJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 597D4802B76;
 Thu, 24 Sep 2020 01:20:42 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7C1D9CBA;
 Thu, 24 Sep 2020 01:20:37 +0000 (UTC)
Subject: Re: [PATCH v8 4/7] scripts: add block-coroutine-wrapper.py
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-5-vsementsov@virtuozzo.com>
 <be6408ba-a430-0294-96e8-a38af7f94c1b@virtuozzo.com>
 <73781605-a817-c627-fea9-183caf84c4b6@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <197997e7-1aea-70c1-0c85-b7a903638d9c@redhat.com>
Date: Wed, 23 Sep 2020 20:20:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <73781605-a817-c627-fea9-183caf84c4b6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 7:00 PM, Eric Blake wrote:

> 
> Tested-by: Eric Blake <eblake@redhat.com>
> 
> There's enough grammar fixes, and the fact that John is working on 
> python cleanups, to make me wonder if we need a v9, or if I should just 
> stage it where it is with any other cleanups as followups.  But I'm 
> liking the reduced maintenance burden once it is in, and don't want to 
> drag it out to the point that it needs more rebasing as other things 
> land first.
> 

Here's what I've squashed in and temporarily pushed to my tree if you 
want to double-check my rebase work:
https://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/master

diff --git a/docs/devel/block-coroutine-wrapper.rst 
b/docs/devel/block-coroutine-wrapper.rst
index f7050bbc8fa6..d09fff2cc539 100644
--- a/docs/devel/block-coroutine-wrapper.rst
+++ b/docs/devel/block-coroutine-wrapper.rst
@@ -2,43 +2,43 @@
  block-coroutine-wrapper
  =======================

-A lot of functions in QEMJ block layer (see ``block/*``) can by called
-only in coroutine context. Such functions are normally marked by
+A lot of functions in QEMU block layer (see ``block/*``) can only be
+called in coroutine context. Such functions are normally marked by the
  coroutine_fn specifier. Still, sometimes we need to call them from
-non-coroutine context, for this we need to start a coroutine, run the
+non-coroutine context; for this we need to start a coroutine, run the
  needed function from it and wait for coroutine finish in
  BDRV_POLL_WHILE() loop. To run a coroutine we need a function with one
-void* argument. So for each coroutine_fn function, which needs
+void* argument. So for each coroutine_fn function which needs a
  non-coroutine interface, we should define a structure to pack the
  parameters, define a separate function to unpack the parameters and
  call the original function and finally define a new interface function
  with same list of arguments as original one, which will pack the
  parameters into a struct, create a coroutine, run it and wait in
-BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand, so
-we have a script to generate them.
+BDRV_POLL_WHILE() loop. It's boring to create such wrappers by hand,
+so we have a script to generate them.

  Usage
  =====

-Assume we have defined ``coroutine_fn`` function
+Assume we have defined the ``coroutine_fn`` function
  ``bdrv_co_foo(<some args>)`` and need a non-coroutine interface for it,
  called ``bdrv_foo(<same args>)``. In this case the script can help. To
  trigger the generation:

-1. You need ``bdrv_foo`` declaration somewhere (for example in
-   ``block/coroutines.h`` with ``generated_co_wrapper`` mark,
+1. You need ``bdrv_foo`` declaration somewhere (for example, in
+   ``block/coroutines.h``) with the ``generated_co_wrapper`` mark,
     like this:

  .. code-block:: c

-    int generated_co_wrapper bdrv_foor(<some args>);
+    int generated_co_wrapper bdrv_foo(<some args>);

  2. You need to feed this declaration to block-coroutine-wrapper script.
-   For this, add .h (or .c) file with the declaration to
+   For this, add the .h (or .c) file with the declaration to the
     ``input: files(...)`` list of ``block_gen_c`` target declaration in
     ``block/meson.build``

-You are done. On build, coroutine wrappers will be generated in
+You are done. During the build, coroutine wrappers will be generated in
  ``<BUILD_DIR>/block/block-gen.c``.

  Links
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index 04773ce076b3..cb0abe1e6988 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -31,3 +31,4 @@ Contents:
     reset
     s390-dasd-ipl
     clocks
+   block-coroutine-wrapper
diff --git a/scripts/block-coroutine-wrapper.py 
b/scripts/block-coroutine-wrapper.py
index d859c07a5f55..8c0a08d9b020 100755
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -2,7 +2,7 @@
  """Generate coroutine wrappers for block subsystem.

  The program parses one or several concatenated c files from stdin,
-searches for functions with 'generated_co_wrapper' specifier
+searches for functions with the 'generated_co_wrapper' specifier
  and generates corresponding wrappers on stdout.

  Usage: block-coroutine-wrapper.py generated-file.c FILE.[ch]...
@@ -39,7 +39,7 @@ def prettify(code: str) -> str:
              'BraceWrapping': {'AfterFunction': True},
              'BreakBeforeBraces': 'Custom',
              'SortIncludes': False,
-            'MaxEmptyLinesToKeep': 2
+            'MaxEmptyLinesToKeep': 2,
          })
          p = subprocess.run(['clang-format', f'-style={style}'], 
check=True,
                             encoding='utf-8', input=code,
@@ -168,7 +168,7 @@ int {func.name}({ func.gen_list('{decl}') })


  def gen_wrappers_file(input_code: str) -> str:
-    res = gen_header()
+    res = ''
      for func in func_decl_iter(input_code):
          res += '\n\n\n'
          res += gen_wrapper(func)
@@ -181,6 +181,7 @@ if __name__ == '__main__':
          exit(f'Usage: {sys.argv[0]} OUT_FILE.c IN_FILE.[ch]...')

      with open(sys.argv[1], 'w') as f_out:
+        f_out.write(gen_header())
          for fname in sys.argv[2:]:
              with open(fname) as f_in:
                  f_out.write(gen_wrappers_file(f_in.read()))
diff --git a/include/block/block.h b/include/block/block.h
index d861883b8d9e..0f0ddc51b49e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -13,7 +13,7 @@
  /*
   * generated_co_wrapper
   *
- * Function specifier, which does nothing but marking functions to be
+ * Function specifier, which does nothing but mark functions to be
   * generated by scripts/block-coroutine-wrapper.py
   *
   * Read more in docs/devel/block-coroutine-wrapper.rst



-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


