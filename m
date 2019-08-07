Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC09C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645AC21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645AC21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJ4K-0001fA-L5
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42745)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvJ3s-000189-MY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvJ3r-0008Qf-AG
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:20:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvJ3r-0008Of-3L
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:20:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so79395403wme.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/rAri6+iQeP3WepN/nkGTsf2jEuOhKyp2BoWZdUANqA=;
 b=FTilQBGbeyYQ8rRlgium9mDMZR3m9kssw5RYk7p7EhKcvIRaI4pynSJ2RQwIeo4UHZ
 vrFV1OoHJB6z/tox/cHDzulKYPZ+USG4eWpI0Wdh97BtXfnAuQtNnnmwkO9bteWuVnov
 UQWt9eG9wMmkg/NlxN1ZGxitE2XQObkHPzgi4u5dqo1EusIOelrSpYcFVqeDH1jIUMwA
 Kszwoyii1/Djul4d6uHJu4yvVlCY8T5S9LERRqNNJrxBE7ti58YhB25Tzwp3bzZ87F7N
 1z6ACeicm2uaVxpRDRF+mLM/+0qlRuo+g+mPVLntGkcQzdYAy3fuer0WKEe7KUrMOqXx
 1zww==
X-Gm-Message-State: APjAAAV7wEvzgkRcH4ufdraeRmMcbq9OFjVS+ka7u0kRJZ2SaZwQOs7u
 pY4crQzP/5i0YUkPURPDnaOGCg==
X-Google-Smtp-Source: APXvYqz74pXpNWGCc53A4+NtsG6zq9Y6Ol4Vk4aJGbVNum4uWO2c4ptIUrF4HiQh9zO08VyNf2MX+A==
X-Received: by 2002:a1c:7e14:: with SMTP id z20mr9609567wmc.83.1565173250080; 
 Wed, 07 Aug 2019 03:20:50 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id e3sm111922015wrs.37.2019.08.07.03.20.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:20:49 -0700 (PDT)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5839fa4e-b6f3-9547-e71d-50be75c4f9fc@redhat.com>
Date: Wed, 7 Aug 2019 12:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807071445.4109-2-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, hari@linux.vnet.ibm.com, clg@kaod.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 8/7/19 9:14 AM, Balamuruhan S wrote:
> Adds scripting interface with python library to call functions in
> python modules from Qemu that can be used to feed input externally
> and without recompiling Qemu that can be used for early development,
> testing and can be extended to abstract some of Qemu code out to a
> python script to ease maintenance.
> 
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  configure                   |  10 +++++
>  include/sysemu/python_api.h |  30 +++++++++++++
>  util/Makefile.objs          |   1 +
>  util/python_api.c           | 100 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 141 insertions(+)
>  create mode 100644 include/sysemu/python_api.h
>  create mode 100644 util/python_api.c
> 
> diff --git a/configure b/configure
> index 714e7fb6a1..fddddcc879 100755
> --- a/configure
> +++ b/configure
> @@ -1866,6 +1866,11 @@ fi
>  # Preserve python version since some functionality is dependent on it
>  python_version=$($python -V 2>&1 | sed -e 's/Python\ //')
>  
> +# Python config to be used for CFLAGS and LDFLAGS
> +if ! [ -z "$python" ]; then
> +    python_config="$python-config"
> +fi
> +
>  # Suppress writing compiled files
>  python="$python -B"
>  
> @@ -6304,6 +6309,11 @@ echo_version() {
>      fi
>  }
>  
> +if ! [ -z "$python_config" ]; then
> +    QEMU_CFLAGS="$QEMU_CFLAGS $($python_config --includes)"
> +    QEMU_LDFLAGS="$QEMU_LDFLAGS $($python_config --ldflags)"
> +fi
> +
>  # prepend pixman and ftd flags after all config tests are done
>  QEMU_CFLAGS="$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
>  QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
> diff --git a/include/sysemu/python_api.h b/include/sysemu/python_api.h
> new file mode 100644
> index 0000000000..ff02d58377
> --- /dev/null
> +++ b/include/sysemu/python_api.h
> @@ -0,0 +1,30 @@
> +#ifndef _PPC_PNV_PYTHON_H
> +#define _PPC_PNV_PYTHON_H
> +
> +#include <stdbool.h>
> +#include <Python.h>
> +
> +extern PyObject *python_callback(const char *abs_module_path, const char *mod,
> +                                 const char *func, char *args[],
> +                                 const int nargs);
> +
> +extern uint64_t python_callback_int(const char *abs_module_path,
> +                                    const char *mod,
> +                                    const char *func, char *args[],
> +                                    const int nargs);
> +
> +extern char *python_callback_str(const char *abs_module_path, const char *mod,
> +                                 const char *func, char *args[],
> +                                 const int nargs);
> +
> +extern bool python_callback_bool(const char *abs_module_path, const char *mod,
> +                                 const char *func, char *args[],
> +                                 const int nargs);
> +
> +extern void python_args_init_cast_int(char *args[], int arg, int pos);
> +
> +extern void python_args_init_cast_long(char *args[], uint64_t arg, int pos);
> +
> +extern void python_args_clean(char *args[], int nargs);
> +
> +#endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 41bf59d127..05851c94a7 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -50,6 +50,7 @@ util-obj-y += range.o
>  util-obj-y += stats64.o
>  util-obj-y += systemd.o
>  util-obj-y += iova-tree.o
> +util-obj-y += python_api.o

This is probably conditional to having python-dev (or whatever distribs
call the package) installed.

>  util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
>  util-obj-$(CONFIG_LINUX) += vfio-helpers.o
>  util-obj-$(CONFIG_POSIX) += drm.o
> diff --git a/util/python_api.c b/util/python_api.c
> new file mode 100644
> index 0000000000..854187e00f
> --- /dev/null
> +++ b/util/python_api.c
> @@ -0,0 +1,100 @@
> +#include "sysemu/python_api.h"
> +#include "qemu/osdep.h"
> +
> +PyObject *python_callback(const char *abs_module_path, const char *mod,
> +                          const char *func, char *args[], const int nargs)
> +{
> +    PyObject *mod_name, *module, *mod_ref, *function, *arguments;
> +    PyObject *result = 0;
> +    PyObject *value = NULL;
> +
> +    /* Set PYTHONPATH to absolute module path directory */
> +    if (!abs_module_path)
> +        abs_module_path = ".";
> +    setenv("PYTHONPATH", abs_module_path, 1);
> +
> +    /* Initialize the Python Interpreter */
> +    Py_Initialize();
> +    mod_name = PyUnicode_FromString(mod);
> +    /* Import module object */
> +    module = PyImport_Import(mod_name);
> +    if (!module) {
> +        PyErr_Print();
> +        fprintf(stderr, "Failed to load \"%s\"\n", mod);
> +        exit(EXIT_FAILURE);
> +    }
> +    mod_ref = PyModule_GetDict(module);
> +    function = PyDict_GetItemString(mod_ref, func);
> +    if (function && PyCallable_Check(function)) {
> +        arguments = PyTuple_New(nargs);
> +        for (int i = 0; i < nargs; i++) {
> +            value = PyUnicode_FromString(args[i]);
> +            if (!value) {
> +                Py_DECREF(arguments);
> +                Py_DECREF(module);
> +                fprintf(stderr, "Cannot convert argument\n");
> +                exit(EXIT_FAILURE);
> +            }
> +            PyTuple_SetItem(arguments, i, value);
> +        }
> +        PyErr_Print();
> +        result = PyObject_CallObject(function, arguments);
> +        PyErr_Print();
> +    }
> +    else {
> +        if (PyErr_Occurred())
> +            PyErr_Print();
> +        fprintf(stderr, "Cannot find function \"%s\"\n", func);
> +        exit(EXIT_FAILURE);
> +    }
> +    /* Clean up */
> +    Py_DECREF(value);
> +    Py_DECREF(module);
> +    Py_DECREF(mod_name);
> +    /* Finish the Python Interpreter */
> +    Py_Finalize();
> +    return result;
> +}
> +
> +uint64_t python_callback_int(const char *abs_module_path, const char *mod,
> +                             const char *func, char *args[], const int nargs)
> +{
> +    PyObject *result;
> +    result = python_callback(abs_module_path, mod, func, args, nargs);
> +    return PyLong_AsLong(result);
> +}
> +
> +char *python_callback_str(const char *abs_module_path, const char *mod,
> +                          const char *func, char *args[], const int nargs)
> +{
> +    PyObject *result;
> +    result = python_callback(abs_module_path, mod, func, args, nargs);
> +    return PyUnicode_AsUTF8(result);
> +}
> +
> +bool python_callback_bool(const char *abs_module_path, const char *mod,
> +                          const char *func, char *args[], const int nargs)
> +{
> +    PyObject *result;
> +    result = python_callback(abs_module_path, mod, func, args, nargs);
> +    return (result == Py_True);
> +}
> +
> +void python_args_init_cast_int(char *args[], int arg, int pos)
> +{
> +    args[pos]= malloc(sizeof(int));
> +    sprintf(args[pos], "%d", arg);
> +}
> +
> +void python_args_init_cast_long(char *args[], uint64_t arg, int pos)
> +{
> +    args[pos]= g_malloc(sizeof(uint64_t) * 2);
> +    sprintf(args[pos], "%lx", arg);
> +}
> +
> +void python_args_clean(char *args[], int nargs)
> +{
> +    for (int i = 0; i < nargs; i++) {
> +        g_free(args[i]);
> +    }
> +}
> 

Wondering about security, is this feature safe to enable in production
environment? It seems to bypass all the hard effort to harden QEMU security.

