Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F356C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F115920748
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB6czNiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F115920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqVJ-0005O0-5o
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyqUb-0004mM-3v
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:43:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37831
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyqUY-0001WV-Nd
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595569413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=+kWvKv+avvTfSYFcQ0RbM+eJ7eVbx4Epf7+5YqD5Pyc=;
 b=cB6czNiSzrKDxpk4idLezl9osyb0F1OhwmnGc6yyyI42RLD8AqNiqMnaaL+8RWJmzv3KXB
 CZkkbB+6U0qFuQLB/91apvAAOMOi876LQNj2UjN6fhlSEQwY0Efj2eIhLMgfTb6byjbgco
 6HixYRsw2bJqbAoccU50XeAQaminPKY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-2D7mULqaPdaupKNI7XFkBQ-1; Fri, 24 Jul 2020 01:43:31 -0400
X-MC-Unique: 2D7mULqaPdaupKNI7XFkBQ-1
Received: by mail-wm1-f69.google.com with SMTP id y204so3537098wmd.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 22:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=+kWvKv+avvTfSYFcQ0RbM+eJ7eVbx4Epf7+5YqD5Pyc=;
 b=Op0eLhJSdUAoTw0qbgYsUGB0XYI5cOVnZzFFMr54zwBbCiUV3MYHwbOSpWbo+7WRfW
 ViDOm9TvrfuAiJEd/Lg7rTfKzyFNZpHEjjRhA3kpsaAX080lX0T9OUp7CvTRcHFjekwy
 Q2WIe3VmiPDkbtSQ450wChRLGU1GzEnMTqYVzG6+flU/rXMhBJ/Ii+ExHFcOmxpXZw/k
 X0p7P/XJuGDc3h3paqd9hOZF4429MX7/gJ2w1iI4r7caUYww/JZIz4ZJP68LrcsqpiLw
 qD1ZCACDH7ZsTrIWftMsVPGlZXOQ7tLQIgIHrDRQ/VVJvr5fJGJkhb589gU8fwz2XWEe
 i0wQ==
X-Gm-Message-State: AOAM530oJzbjhijxWyHO3vdi1iYuuGJCtv3g5Zg/rd9eXQfWV+zLCNn1
 nXpIeKv/j3WG6tIdL9mv2iz51bRtEUSQYuZJNjdGI7e6rtI5iU9jNLIXmTWf9lLwJ4wBUOrx0Lz
 yLozdjngMqzuvAqc=
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr6912340wmu.142.1595569410610; 
 Thu, 23 Jul 2020 22:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2ZJ+W/akNscSqlr9mRAWn1T3gnr1q2G5Cfb9V00MgnuAb3pdcWsA8Te0kqaIkUhp6gwQb7A==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr6912324wmu.142.1595569410391; 
 Thu, 23 Jul 2020 22:43:30 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n5sm5897409wmi.34.2020.07.23.22.43.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 22:43:29 -0700 (PDT)
To: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 avocado-devel <avocado-devel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: Avocado error fetching QEMU boot_linux.py assets
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <9173c3d6-df1f-b719-f124-fc6cf3ecb9f6@redhat.com>
Date: Fri, 24 Jul 2020 07:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

[cross list post]

Using QEMU at commit 3cbc8970f5 I'm getting this error:

Fetching assets from tests/acceptance/boot_linux_console.py.
Fetching assets from tests/acceptance/boot_linux.py.
Traceback (most recent call last):
  File "/usr/lib64/python3.7/runpy.py", line 193, in _run_module_as_main
    "__main__", mod_spec)
  File "/usr/lib64/python3.7/runpy.py", line 85, in _run_code
    exec(code, run_globals)
  File
"/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/__main__.py",
line 11, in <module>
    sys.exit(main.run())
  File
"/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/core/app.py",
line 91, in run
    return method(self.parser.config)
  File
"/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
line 291, in run
    success, fail = fetch_assets(test_file)
  File
"/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
line 200, in fetch_assets
    handler = FetchAssetHandler(test_file, klass, method)
  File
"/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
line 65, in __init__
    self.visit(self.tree)
  File "/usr/lib64/python3.7/ast.py", line 271, in visit
    return visitor(node)
  File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
    self.visit(item)
  File "/usr/lib64/python3.7/ast.py", line 271, in visit
    return visitor(node)
  File
"/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
line 139, in visit_ClassDef
    self.generic_visit(node)
  File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
    self.visit(item)
  File "/usr/lib64/python3.7/ast.py", line 271, in visit
    return visitor(node)
  File
"/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py",
line 171, in visit_Assign
    self.asgmts[cur_klass][cur_method][name] = node.value.s
KeyError: 'launch_and_wait'

Same if I revert these:
0f26d94ec9 ("tests/acceptance: skip s390x_ccw_vrtio_tcg on GitLab")
1c80c87c8c ("tests/acceptance: refactor boot_linux to allow code reuse")

If I remove boot_linux.py, all other files are processed correctly.

Any idea what can be wrong here?

Thanks,

Phil.


