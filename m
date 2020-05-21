Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F84C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF22420721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoKSxt/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF22420721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbjBv-0004qn-VH
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbjAm-0003oJ-Uz
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:15:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbjAl-0003vb-Qd
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590059735;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BRWdBXcNIl2FgtUAJJIFaLVynEbNAlqPR3PKkHCI8D8=;
 b=aoKSxt/9TKDjRiKqQKZUWoHpbdB/A+HTYPpjn19SYqP+zRkPT3CiOi/CCkWSyNs9YB4afa
 ZX5TDfPXuKGq7ZqODFYWaWcIpKRJvJO2uUaaXIHALD6xbiiZkflh4VSXRbeevJJMV0W+Vd
 2RfvrLuBRvTBtw7at8WZeimr3S5SYJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-101yQws9Pn6NEYuWZZ7L8Q-1; Thu, 21 May 2020 07:15:27 -0400
X-MC-Unique: 101yQws9Pn6NEYuWZZ7L8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4745318FE861;
 Thu, 21 May 2020 11:15:26 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1438D2E18E;
 Thu, 21 May 2020 11:15:24 +0000 (UTC)
Date: Thu, 21 May 2020 12:15:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [PATCH v3 3/3] test-crypto-secret: add 'secret_keyring' object
 tests.
Message-ID: <20200521111522.GG2211791@redhat.com>
References: <20200518202804.3761-1-alex-krasikov@yandex-team.ru>
 <20200518202804.3761-4-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200518202804.3761-4-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 11:28:04PM +0300, Alexey Krasikov wrote:
> Add tests:
>   test_secret_keyring_good;
>   test_secret_keyring_revoked_key;
>   test_secret_keyring_expired_key;
>   test_secret_keyring_bad_serial_key;
>   test_secret_keyring_bad_key_access_right;
> 
> Added tests require libkeyutils. The absence of this library is not
> critical, because these tests will be skipped in this case.
> 
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  configure                  |  25 ++++++
>  tests/Makefile.include     |   4 +
>  tests/test-crypto-secret.c | 154 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
> 
> diff --git a/configure b/configure
> index 1bae5ec0a1..2ab7d2961c 100755
> --- a/configure
> +++ b/configure
> @@ -6283,6 +6283,28 @@ but not implemented on your system"
>      fi
>  fi
>  
> +##########################################
> +# check for usable keyutils.h
> +
> +if test "$linux" = "yes" ; then
> +
> +    have_keyutils=no
> +    cat > $TMPC << EOF
> +#include <errno.h>
> +#include <asm/unistd.h>
> +#include <linux/keyctl.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <keyutils.h>
> +int main(void) {
> +    return request_key("user", NULL, NULL, 0);
> +}
> +EOF
> +    if compile_prog "" "-lkeyutils"; then
> +        have_keyutils=yes
> +    fi
> +fi

On my Fedora 32 system this always fails despite having keyutils-libs-devel
installed. Looking at config.log,  the linux/keyctl.h file defines structs
with names that clash with those in keyutils.h.  Removing the linux/keyctl.h
include here makes this test succeed, but.....


> +/*
> + * TODO
> + * test_secret_keyring_bad_key_access_right() is not working yet.
> + * We don't know yet if this due a bug in the Linux kernel or
> + * whether it's normal syscall behavior.
> + * We've requested information from kernel maintainers.
> + * See: <https://www.spinics.net/lists/keyrings/index.html>
> + * Thread: 'security/keys: remove possessor verify after key permission check'
> + */
> +
> +static void test_secret_keyring_bad_key_access_right(void)
> +{
> +    char key_str[16];
> +    Object *sec;
> +    int32_t key = add_key("user", DESCRIPTION, PAYLOAD,
> +                          strlen(PAYLOAD), KEY_SPEC_PROCESS_KEYRING);
> +    g_assert(key >= 0);
> +    g_assert_false(keyctl_setperm(key, KEY_POS_ALL & (~KEY_POS_READ)));
> +
> +    snprintf(key_str, sizeof(key_str), "0x%08x", key);
> +
> +    sec = object_new_with_props(
> +        TYPE_QCRYPTO_SECRET_KEYRING,
> +        object_get_objects_root(),
> +        "sec0",
> +        NULL,
> +        "serial", key_str,
> +        NULL);
> +
> +    g_assert(errno == EACCES);
> +    g_assert(sec == NULL);
> +
> +    keyctl_unlink(key, KEY_SPEC_PROCESS_KEYRING);
> +}

This causes the entire test suite to abort

ERROR:tests/test-crypto-secret.c:261:test_secret_keyring_bad_key_access_right: assertion failed: (errno == EACCES)
Bail out! ERROR:tests/test-crypto-secret.c:261:test_secret_keyring_bad_key_access_right: assertion failed: (errno == EACCES)

Either this test needs a temporary  "g_test_skip()" at the start of the
method to stop executing (if we expect Linux to be fixed), or it just 
needs deleting (if this is intentional Linux behaviour)

> +
> +#endif /* CONFIG_TEST_SECRET_KEYRING */
>  
>  static void test_secret_noconv_base64_good(void)
>  {
> @@ -426,6 +567,19 @@ int main(int argc, char **argv)
>      g_test_add_func("/crypto/secret/indirect/emptyfile",
>                      test_secret_indirect_emptyfile);
>  
> +#ifdef CONFIG_TEST_SECRET_KEYRING
> +    g_test_add_func("/crypto/secret/keyring/good",
> +                    test_secret_keyring_good);
> +    g_test_add_func("/crypto/secret/keyring/revoked_key",
> +                    test_secret_keyring_revoked_key);
> +    g_test_add_func("/crypto/secret/keyring/expired_key",
> +                    test_secret_keyring_expired_key);
> +    g_test_add_func("/crypto/secret/keyring/bad_serial_key",
> +                    test_secret_keyring_bad_serial_key);
> +    g_test_add_func("/crypto/secret/keyring/bad_key_access_right",
> +                    test_secret_keyring_bad_key_access_right);
> +#endif /* CONFIG_TEST_SECRET_KEYRING */
> +

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


